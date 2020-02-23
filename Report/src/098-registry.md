## Registry \label{app_registry}

### ABI

```
[
	{"constant":false,"inputs":[{"name":"_new","type":"address"}],"name":"setOwner","outputs":[],"payable":false,"type":"function"},
	{"constant":false,"inputs":[{"name":"_who","type":"address"}],"name":"certify","outputs":[],"payable":false,"type":"function"},
	{"constant":true,"inputs":[{"name":"_who","type":"address"},{"name":"_field","type":"string"}],"name":"getAddress","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},
	{"constant":false,"inputs":[{"name":"_who","type":"address"}],"name":"revoke","outputs":[],"payable":false,"type":"function"},
	{"constant":true,"inputs":[],"name":"owner","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},
	{"constant":true,"inputs":[],"name":"delegate","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},
	{"constant":true,"inputs":[{"name":"_who","type":"address"},{"name":"_field","type":"string"}],"name":"getUint","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},
	{"constant":false,"inputs":[{"name":"_new","type":"address"}],"name":"setDelegate","outputs":[],"payable":false,"type":"function"},
	{"constant":true,"inputs":[{"name":"_who","type":"address"}],"name":"certified","outputs":[{"name":"","type":"bool"}],"payable":false,"type":"function"},
	{"constant":true,"inputs":[{"name":"_who","type":"address"},{"name":"_field","type":"string"}],"name":"get","outputs":[{"name":"","type":"bytes32"}],"payable":false,"type":"function"}
]
```

### Owned.sol

```
//! The owned contract.
//!
//! Copyright 2016 Gavin Wood, Parity Technologies Ltd.
//!
//! Licensed under the Apache License, Version 2.0 (the "License");
//! you may not use this file except in compliance with the License.
//! You may obtain a copy of the License at
//!
//!     http://www.apache.org/licenses/LICENSE-2.0
//!
//! Unless required by applicable law or agreed to in writing, software
//! distributed under the License is distributed on an "AS IS" BASIS,
//! WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//! See the License for the specific language governing permissions and
//! limitations under the License.

pragma solidity ^0.4.24;


contract Owned {
	event NewOwner(address indexed old, address indexed current);

	address public owner = msg.sender;

	modifier onlyOwner {
		require(msg.sender == owner);
		_;
	}

	function setOwner(address _new)
		external
		onlyOwner
	{
		emit NewOwner(owner, _new);
		owner = _new;
	}
}
```

### Registry.sol

```
//! The registry interface.
//!
//! Copyright 2016 Gavin Wood, Parity Technologies Ltd.
//!
//! Licensed under the Apache License, Version 2.0 (the "License");
//! you may not use this file except in compliance with the License.
//! You may obtain a copy of the License at
//!
//!     http://www.apache.org/licenses/LICENSE-2.0
//!
//! Unless required by applicable law or agreed to in writing, software
//! distributed under the License is distributed on an "AS IS" BASIS,
//! WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//! See the License for the specific language governing permissions and
//! limitations under the License.

pragma solidity ^0.4.24;


interface MetadataRegistry {
	event DataChanged(bytes32 indexed name, string key, string plainKey);

	function getData(bytes32 _name, string _key)
		external
		view
		returns (bytes32);

	function getAddress(bytes32 _name, string _key)
		external
		view
		returns (address);

	function getUint(bytes32 _name, string _key)
		external
		view
		returns (uint);
}


interface OwnerRegistry {
	event Reserved(bytes32 indexed name, address indexed owner);
	event Transferred(bytes32 indexed name, address indexed oldOwner, address indexed newOwner);
	event Dropped(bytes32 indexed name, address indexed owner);

	function getOwner(bytes32 _name)
		external
		view
		returns (address);
}


interface ReverseRegistry {
	event ReverseConfirmed(string name, address indexed reverse);
	event ReverseRemoved(string name, address indexed reverse);

	function hasReverse(bytes32 _name)
		external
		view
		returns (bool);

	function getReverse(bytes32 _name)
		external
		view
		returns (address);

	function canReverse(address _data)
		external
		view
		returns (bool);

	function reverse(address _data)
		external
		view
		returns (string);
}
```

### SimpleRegistry.sol

```
//! The simple registry contract.
//!
//! Copyright 2016 Gavin Wood, Parity Technologies Ltd.
//!
//! Licensed under the Apache License, Version 2.0 (the "License");
//! you may not use this file except in compliance with the License.
//! You may obtain a copy of the License at
//!
//!     http://www.apache.org/licenses/LICENSE-2.0
//!
//! Unless required by applicable law or agreed to in writing, software
//! distributed under the License is distributed on an "AS IS" BASIS,
//! WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//! See the License for the specific language governing permissions and
//! limitations under the License.

pragma solidity ^0.4.24;

import "./Owned.sol";
import "./Registry.sol";


contract SimpleRegistry is Owned, MetadataRegistry, OwnerRegistry, ReverseRegistry {
	struct Entry {
		address owner;
		address reverse;
		bool deleted;
		mapping (string => bytes32) data;
	}

	event Drained(uint amount);
	event FeeChanged(uint amount);
	event ReverseProposed(string name, address indexed reverse);

	mapping (bytes32 => Entry) entries;
	mapping (address => string) reverses;

	uint public fee = 1 ether;

	modifier whenUnreserved(bytes32 _name) {
		require(!entries[_name].deleted && entries[_name].owner == 0);
		_;
	}

	modifier onlyOwnerOf(bytes32 _name) {
		require(entries[_name].owner == msg.sender);
		_;
	}

	modifier whenProposed(string _name) {
		require(entries[keccak256(bytes(_name))].reverse == msg.sender);
		_;
	}

	modifier whenEntry(string _name) {
		require(
			!entries[keccak256(bytes(_name))].deleted &&
			entries[keccak256(bytes(_name))].owner != address(0)
		);
		_;
	}

	modifier whenEntryRaw(bytes32 _name) {
		require(
			!entries[_name].deleted &&
			entries[_name].owner != address(0)
		);
		_;
	}

	modifier whenFeePaid {
		require(msg.value >= fee);
		_;
	}

	// Reservation functions
	function reserve(bytes32 _name)
		external
		payable
		whenUnreserved(_name)
		whenFeePaid
		returns (bool success)
	{
		entries[_name].owner = msg.sender;
		emit Reserved(_name, msg.sender);
		return true;
	}

	function transfer(bytes32 _name, address _to)
		external
		whenEntryRaw(_name)
		onlyOwnerOf(_name)
		returns (bool success)
	{
		entries[_name].owner = _to;
		emit Transferred(_name, msg.sender, _to);
		return true;
	}

	function drop(bytes32 _name)
		external
		whenEntryRaw(_name)
		onlyOwnerOf(_name)
		returns (bool success)
	{
		if (keccak256(bytes(reverses[entries[_name].reverse])) == _name) {
			emit ReverseRemoved(reverses[entries[_name].reverse], entries[_name].reverse);
			delete reverses[entries[_name].reverse];
		}
		entries[_name].deleted = true;
		emit Dropped(_name, msg.sender);
		return true;
	}

	// Data admin functions
	function setData(bytes32 _name, string _key, bytes32 _value)
		external
		whenEntryRaw(_name)
		onlyOwnerOf(_name)
		returns (bool success)
	{
		entries[_name].data[_key] = _value;
		emit DataChanged(_name, _key, _key);
		return true;
	}

	function setAddress(bytes32 _name, string _key, address _value)
		external
		whenEntryRaw(_name)
		onlyOwnerOf(_name)
		returns (bool success)
	{
		entries[_name].data[_key] = bytes32(_value);
		emit DataChanged(_name, _key, _key);
		return true;
	}

	function setUint(bytes32 _name, string _key, uint _value)
		external
		whenEntryRaw(_name)
		onlyOwnerOf(_name)
		returns (bool success)
	{
		entries[_name].data[_key] = bytes32(_value);
		emit DataChanged(_name, _key, _key);
		return true;
	}

	// Reverse registration functions
	function proposeReverse(string _name, address _who)
		external
		whenEntry(_name)
		onlyOwnerOf(keccak256(bytes(_name)))
		returns (bool success)
	{
		bytes32 sha3Name = keccak256(bytes(_name));
		if (entries[sha3Name].reverse != 0 && keccak256(bytes(reverses[entries[sha3Name].reverse])) == sha3Name) {
			delete reverses[entries[sha3Name].reverse];
			emit ReverseRemoved(_name, entries[sha3Name].reverse);
		}
		entries[sha3Name].reverse = _who;
		emit ReverseProposed(_name, _who);
		return true;
	}

	function confirmReverse(string _name)
		external
		whenEntry(_name)
		whenProposed(_name)
		returns (bool success)
	{
		reverses[msg.sender] = _name;
		emit ReverseConfirmed(_name, msg.sender);
		return true;
	}

	function confirmReverseAs(string _name, address _who)
		external
		whenEntry(_name)
		onlyOwner
		returns (bool success)
	{
		reverses[_who] = _name;
		emit ReverseConfirmed(_name, _who);
		return true;
	}

	function removeReverse()
		external
		whenEntry(reverses[msg.sender])
	{
		emit ReverseRemoved(reverses[msg.sender], msg.sender);
		delete entries[keccak256(bytes(reverses[msg.sender]))].reverse;
		delete reverses[msg.sender];
	}

	// Admin functions for the owner
	function setFee(uint _amount)
		external
		onlyOwner
		returns (bool)
	{
		fee = _amount;
		emit FeeChanged(_amount);
		return true;
	}

	function drain()
		external
		onlyOwner
		returns (bool)
	{
		emit Drained(address(this).balance);
		msg.sender.transfer(address(this).balance);
		return true;
	}

	// MetadataRegistry views
	function getData(bytes32 _name, string _key)
		external
		view
		whenEntryRaw(_name)
		returns (bytes32)
	{
		return entries[_name].data[_key];
	}

	function getAddress(bytes32 _name, string _key)
		external
		view
		whenEntryRaw(_name)
		returns (address)
	{
		return address(entries[_name].data[_key]);
	}

	function getUint(bytes32 _name, string _key)
		external
		view
		whenEntryRaw(_name)
		returns (uint)
	{
		return uint(entries[_name].data[_key]);
	}

	// OwnerRegistry views
	function getOwner(bytes32 _name)
		external
		view
		whenEntryRaw(_name)
		returns (address)
	{
		return entries[_name].owner;
	}

	// ReversibleRegistry views
	function hasReverse(bytes32 _name)
		external
		view
		whenEntryRaw(_name)
		returns (bool)
	{
		return entries[_name].reverse != 0;
	}

	function getReverse(bytes32 _name)
		external
		view
		whenEntryRaw(_name)
		returns (address)
	{
		return entries[_name].reverse;
	}

	function canReverse(address _data)
		external
		view
		returns (bool)
	{
		return bytes(reverses[_data]).length != 0;
	}

	function reverse(address _data)
		external
		view
		returns (string)
	{
		return reverses[_data];
	}

	function reserved(bytes32 _name)
		external
		view
		whenEntryRaw(_name)
		returns (bool)
	{
		return entries[_name].owner != 0;
	}
}
```

### Java-Wrapper für SimpleRegistry \label{sec_app_simpleRegistry_java}

```
package ch.brugg.fhnw.btm.contracts;

import io.reactivex.Flowable;
import org.web3j.abi.EventEncoder;
import org.web3j.abi.TypeReference;
import org.web3j.abi.datatypes.*;
import org.web3j.abi.datatypes.generated.Bytes32;
import org.web3j.abi.datatypes.generated.Uint256;
import org.web3j.crypto.Credentials;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.core.DefaultBlockParameter;
import org.web3j.protocol.core.RemoteCall;
import org.web3j.protocol.core.RemoteFunctionCall;
import org.web3j.protocol.core.methods.request.EthFilter;
import org.web3j.protocol.core.methods.response.BaseEventResponse;
import org.web3j.protocol.core.methods.response.Log;
import org.web3j.protocol.core.methods.response.TransactionReceipt;
import org.web3j.tx.Contract;
import org.web3j.tx.TransactionManager;
import org.web3j.tx.gas.ContractGasProvider;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/**
 * <p>Auto generated code.
 * <p><strong>Do not modify!</strong>
 * <p>Please use the <a href="https://docs.web3j.io/command_line.html">web3j command line tools</a>,
 * or the org.web3j.codegen.SolidityFunctionWrapperGenerator in the 
 * <a href="https://github.com/web3j/web3j/tree/master/codegen">codegen module</a> to update.
 *
 * <p>Generated with web3j version 4.5.11.
 *
 * Generated with:
 * web3j solidity generate -b .\src\main\resources\solidity\Registry\out\SimpleRegistry.bin -a .\src\main\resources\solidity\Registry\out\SimpleRegistry.abi -o .\src\main\java -p io.kauri.tutorials.java_ethereum.contracts
 */
@SuppressWarnings("rawtypes")
public class SimpleRegistry extends Contract {
    public static final String BINARY = "Platzhalter für BinaryCode";

    public static final String FUNC_CANREVERSE = "canReverse";

    public static final String FUNC_SETOWNER = "setOwner";

    public static final String FUNC_SETDATA = "setData";

    public static final String FUNC_CONFIRMREVERSE = "confirmReverse";

    public static final String FUNC_RESERVE = "reserve";

    public static final String FUNC_DROP = "drop";

    public static final String FUNC_GETADDRESS = "getAddress";

    public static final String FUNC_SETFEE = "setFee";

    public static final String FUNC_TRANSFER = "transfer";

    public static final String FUNC_OWNER = "owner";

    public static final String FUNC_GETDATA = "getData";

    public static final String FUNC_RESERVED = "reserved";

    public static final String FUNC_DRAIN = "drain";

    public static final String FUNC_PROPOSEREVERSE = "proposeReverse";

    public static final String FUNC_HASREVERSE = "hasReverse";

    public static final String FUNC_GETUINT = "getUint";

    public static final String FUNC_FEE = "fee";

    public static final String FUNC_GETOWNER = "getOwner";

    public static final String FUNC_GETREVERSE = "getReverse";

    public static final String FUNC_REVERSE = "reverse";

    public static final String FUNC_SETUINT = "setUint";

    public static final String FUNC_CONFIRMREVERSEAS = "confirmReverseAs";

    public static final String FUNC_REMOVEREVERSE = "removeReverse";

    public static final String FUNC_SETADDRESS = "setAddress";

    public static final Event DRAINED_EVENT = new Event("Drained", 
            Arrays.<TypeReference<?>>asList(new TypeReference<Uint256>() {}));
    ;

    public static final Event FEECHANGED_EVENT = new Event("FeeChanged", 
            Arrays.<TypeReference<?>>asList(new TypeReference<Uint256>() {}));
    ;

    public static final Event REVERSEPROPOSED_EVENT = new Event("ReverseProposed", 
            Arrays.<TypeReference<?>>asList(new TypeReference<Utf8String>() {}, new TypeReference<Address>(true) {}));
    ;

    public static final Event REVERSECONFIRMED_EVENT = new Event("ReverseConfirmed", 
            Arrays.<TypeReference<?>>asList(new TypeReference<Utf8String>() {}, new TypeReference<Address>(true) {}));
    ;

    public static final Event REVERSEREMOVED_EVENT = new Event("ReverseRemoved", 
            Arrays.<TypeReference<?>>asList(new TypeReference<Utf8String>() {}, new TypeReference<Address>(true) {}));
    ;

    public static final Event RESERVED_EVENT = new Event("Reserved", 
            Arrays.<TypeReference<?>>asList(new TypeReference<Bytes32>(true) {}, new TypeReference<Address>(true) {}));
    ;

    public static final Event TRANSFERRED_EVENT = new Event("Transferred", 
            Arrays.<TypeReference<?>>asList(new TypeReference<Bytes32>(true) {}, new TypeReference<Address>(true) {}, new TypeReference<Address>(true) {}));
    ;

    public static final Event DROPPED_EVENT = new Event("Dropped", 
            Arrays.<TypeReference<?>>asList(new TypeReference<Bytes32>(true) {}, new TypeReference<Address>(true) {}));
    ;

    public static final Event DATACHANGED_EVENT = new Event("DataChanged", 
            Arrays.<TypeReference<?>>asList(new TypeReference<Bytes32>(true) {}, new TypeReference<Utf8String>() {}, new TypeReference<Utf8String>() {}));
    ;

    public static final Event NEWOWNER_EVENT = new Event("NewOwner", 
            Arrays.<TypeReference<?>>asList(new TypeReference<Address>(true) {}, new TypeReference<Address>(true) {}));
    ;

    @Deprecated
    protected SimpleRegistry(String contractAddress, Web3j web3j, Credentials credentials, BigInteger gasPrice, BigInteger gasLimit) {
        super(BINARY, contractAddress, web3j, credentials, gasPrice, gasLimit);
    }

    protected SimpleRegistry(String contractAddress, Web3j web3j, Credentials credentials, ContractGasProvider contractGasProvider) {
        super(BINARY, contractAddress, web3j, credentials, contractGasProvider);
    }

    @Deprecated
    protected SimpleRegistry(String contractAddress, Web3j web3j, TransactionManager transactionManager, BigInteger gasPrice, BigInteger gasLimit) {
        super(BINARY, contractAddress, web3j, transactionManager, gasPrice, gasLimit);
    }

    protected SimpleRegistry(String contractAddress, Web3j web3j, TransactionManager transactionManager, ContractGasProvider contractGasProvider) {
        super(BINARY, contractAddress, web3j, transactionManager, contractGasProvider);
    }

    public RemoteFunctionCall<Boolean> canReverse(String _data) {
        final Function function = new Function(FUNC_CANREVERSE, 
                Arrays.<Type>asList(new Address(160, _data)),
                Arrays.<TypeReference<?>>asList(new TypeReference<Bool>() {}));
        return executeRemoteCallSingleValueReturn(function, Boolean.class);
    }

    public RemoteFunctionCall<TransactionReceipt> setOwner(String _new) {
        final Function function = new Function(
                FUNC_SETOWNER,
                Arrays.<Type>asList(new Address(160, _new)),
                Collections.<TypeReference<?>>emptyList());
        return executeRemoteCallTransaction(function);
    }

    public RemoteFunctionCall<TransactionReceipt> setData(byte[] _name, String _key, byte[] _value) {
        final Function function = new Function(
                FUNC_SETDATA,
                Arrays.<Type>asList(new Bytes32(_name),
                new Utf8String(_key),
                new Bytes32(_value)),
                Collections.<TypeReference<?>>emptyList());
        return executeRemoteCallTransaction(function);
    }

    public RemoteFunctionCall<TransactionReceipt> confirmReverse(String _name) {
        final Function function = new Function(
                FUNC_CONFIRMREVERSE,
                Arrays.<Type>asList(new Utf8String(_name)),
                Collections.<TypeReference<?>>emptyList());
        return executeRemoteCallTransaction(function);
    }

    public RemoteFunctionCall<TransactionReceipt> reserve(byte[] _name, BigInteger weiValue) {
        final Function function = new Function(
                FUNC_RESERVE,
                Arrays.<Type>asList(new Bytes32(_name)),
                Collections.<TypeReference<?>>emptyList());
        return executeRemoteCallTransaction(function, weiValue);
    }

    public RemoteFunctionCall<TransactionReceipt> drop(byte[] _name) {
        final Function function = new Function(
                FUNC_DROP,
                Arrays.<Type>asList(new Bytes32(_name)),
                Collections.<TypeReference<?>>emptyList());
        return executeRemoteCallTransaction(function);
    }

    public RemoteFunctionCall<String> getAddress(byte[] _name, String _key) {
        final Function function = new Function(FUNC_GETADDRESS,
                Arrays.<Type>asList(new Bytes32(_name),
                new Utf8String(_key)),
                Arrays.<TypeReference<?>>asList(new TypeReference<Address>() {}));
        return executeRemoteCallSingleValueReturn(function, String.class);
    }

    public RemoteFunctionCall<TransactionReceipt> setFee(BigInteger _amount) {
        final Function function = new Function(
                FUNC_SETFEE,
                Arrays.<Type>asList(new Uint256(_amount)),
                Collections.<TypeReference<?>>emptyList());
        return executeRemoteCallTransaction(function);
    }

    public RemoteFunctionCall<TransactionReceipt> transfer(byte[] _name, String _to) {
        final Function function = new Function(
                FUNC_TRANSFER,
                Arrays.<Type>asList(new Bytes32(_name),
                new Address(160, _to)),
                Collections.<TypeReference<?>>emptyList());
        return executeRemoteCallTransaction(function);
    }

    public RemoteFunctionCall<String> owner() {
        final Function function = new Function(FUNC_OWNER,
                Arrays.<Type>asList(),
                Arrays.<TypeReference<?>>asList(new TypeReference<Address>() {}));
        return executeRemoteCallSingleValueReturn(function, String.class);
    }

    public RemoteFunctionCall<byte[]> getData(byte[] _name, String _key) {
        final Function function = new Function(FUNC_GETDATA,
                Arrays.<Type>asList(new Bytes32(_name),
                new Utf8String(_key)),
                Arrays.<TypeReference<?>>asList(new TypeReference<Bytes32>() {}));
        return executeRemoteCallSingleValueReturn(function, byte[].class);
    }

    public RemoteFunctionCall<Boolean> reserved(byte[] _name) {
        final Function function = new Function(FUNC_RESERVED,
                Arrays.<Type>asList(new Bytes32(_name)),
                Arrays.<TypeReference<?>>asList(new TypeReference<Bool>() {}));
        return executeRemoteCallSingleValueReturn(function, Boolean.class);
    }

    public RemoteFunctionCall<TransactionReceipt> drain() {
        final Function function = new Function(
                FUNC_DRAIN,
                Arrays.<Type>asList(),
                Collections.<TypeReference<?>>emptyList());
        return executeRemoteCallTransaction(function);
    }

    public RemoteFunctionCall<TransactionReceipt> proposeReverse(String _name, String _who) {
        final Function function = new Function(
                FUNC_PROPOSEREVERSE,
                Arrays.<Type>asList(new Utf8String(_name),
                new Address(160, _who)),
                Collections.<TypeReference<?>>emptyList());
        return executeRemoteCallTransaction(function);
    }

    public RemoteFunctionCall<Boolean> hasReverse(byte[] _name) {
        final Function function = new Function(FUNC_HASREVERSE,
                Arrays.<Type>asList(new Bytes32(_name)),
                Arrays.<TypeReference<?>>asList(new TypeReference<Bool>() {}));
        return executeRemoteCallSingleValueReturn(function, Boolean.class);
    }

    public RemoteFunctionCall<BigInteger> getUint(byte[] _name, String _key) {
        final Function function = new Function(FUNC_GETUINT,
                Arrays.<Type>asList(new Bytes32(_name),
                new Utf8String(_key)),
                Arrays.<TypeReference<?>>asList(new TypeReference<Uint256>() {}));
        return executeRemoteCallSingleValueReturn(function, BigInteger.class);
    }

    public RemoteFunctionCall<BigInteger> fee() {
        final Function function = new Function(FUNC_FEE,
                Arrays.<Type>asList(),
                Arrays.<TypeReference<?>>asList(new TypeReference<Uint256>() {}));
        return executeRemoteCallSingleValueReturn(function, BigInteger.class);
    }

    public RemoteFunctionCall<String> getOwner(byte[] _name) {
        final Function function = new Function(FUNC_GETOWNER,
                Arrays.<Type>asList(new Bytes32(_name)),
                Arrays.<TypeReference<?>>asList(new TypeReference<Address>() {}));
        return executeRemoteCallSingleValueReturn(function, String.class);
    }

    public RemoteFunctionCall<String> getReverse(byte[] _name) {
        final Function function = new Function(FUNC_GETREVERSE,
                Arrays.<Type>asList(new Bytes32(_name)),
                Arrays.<TypeReference<?>>asList(new TypeReference<Address>() {}));
        return executeRemoteCallSingleValueReturn(function, String.class);
    }

    public RemoteFunctionCall<String> reverse(String _data) {
        final Function function = new Function(FUNC_REVERSE,
                Arrays.<Type>asList(new Address(160, _data)),
                Arrays.<TypeReference<?>>asList(new TypeReference<Utf8String>() {}));
        return executeRemoteCallSingleValueReturn(function, String.class);
    }

    public RemoteFunctionCall<TransactionReceipt> setUint(byte[] _name, String _key, BigInteger _value) {
        final Function function = new Function(
                FUNC_SETUINT,
                Arrays.<Type>asList(new Bytes32(_name),
                new Utf8String(_key),
                new Uint256(_value)),
                Collections.<TypeReference<?>>emptyList());
        return executeRemoteCallTransaction(function);
    }

    public RemoteFunctionCall<TransactionReceipt> confirmReverseAs(String _name, String _who) {
        final Function function = new Function(
                FUNC_CONFIRMREVERSEAS,
                Arrays.<Type>asList(new Utf8String(_name),
                new Address(160, _who)),
                Collections.<TypeReference<?>>emptyList());
        return executeRemoteCallTransaction(function);
    }

    public RemoteFunctionCall<TransactionReceipt> removeReverse() {
        final Function function = new Function(
                FUNC_REMOVEREVERSE,
                Arrays.<Type>asList(),
                Collections.<TypeReference<?>>emptyList());
        return executeRemoteCallTransaction(function);
    }

    public RemoteFunctionCall<TransactionReceipt> setAddress(byte[] _name, String _key, String _value) {
        final Function function = new Function(
                FUNC_SETADDRESS,
                Arrays.<Type>asList(new Bytes32(_name),
                new Utf8String(_key),
                new Address(160, _value)),
                Collections.<TypeReference<?>>emptyList());
        return executeRemoteCallTransaction(function);
    }

    public List<DrainedEventResponse> getDrainedEvents(TransactionReceipt transactionReceipt) {
        List<EventValuesWithLog> valueList = extractEventParametersWithLog(DRAINED_EVENT, transactionReceipt);
        ArrayList<DrainedEventResponse> responses = new ArrayList<DrainedEventResponse>(valueList.size());
        for (EventValuesWithLog eventValues : valueList) {
            DrainedEventResponse typedResponse = new DrainedEventResponse();
            typedResponse.log = eventValues.getLog();
            typedResponse.amount = (BigInteger) eventValues.getNonIndexedValues().get(0).getValue();
            responses.add(typedResponse);
        }
        return responses;
    }

    public Flowable<DrainedEventResponse> drainedEventFlowable(EthFilter filter) {
        return web3j.ethLogFlowable(filter).map(new io.reactivex.functions.Function<Log, DrainedEventResponse>() {
            @Override
            public DrainedEventResponse apply(Log log) {
                EventValuesWithLog eventValues = extractEventParametersWithLog(DRAINED_EVENT, log);
                DrainedEventResponse typedResponse = new DrainedEventResponse();
                typedResponse.log = log;
                typedResponse.amount = (BigInteger) eventValues.getNonIndexedValues().get(0).getValue();
                return typedResponse;
            }
        });
    }

    public Flowable<DrainedEventResponse> drainedEventFlowable(DefaultBlockParameter startBlock, DefaultBlockParameter endBlock) {
        EthFilter filter = new EthFilter(startBlock, endBlock, getContractAddress());
        filter.addSingleTopic(EventEncoder.encode(DRAINED_EVENT));
        return drainedEventFlowable(filter);
    }

    public List<FeeChangedEventResponse> getFeeChangedEvents(TransactionReceipt transactionReceipt) {
        List<EventValuesWithLog> valueList = extractEventParametersWithLog(FEECHANGED_EVENT, transactionReceipt);
        ArrayList<FeeChangedEventResponse> responses = new ArrayList<FeeChangedEventResponse>(valueList.size());
        for (EventValuesWithLog eventValues : valueList) {
            FeeChangedEventResponse typedResponse = new FeeChangedEventResponse();
            typedResponse.log = eventValues.getLog();
            typedResponse.amount = (BigInteger) eventValues.getNonIndexedValues().get(0).getValue();
            responses.add(typedResponse);
        }
        return responses;
    }

    public Flowable<FeeChangedEventResponse> feeChangedEventFlowable(EthFilter filter) {
        return web3j.ethLogFlowable(filter).map(new io.reactivex.functions.Function<Log, FeeChangedEventResponse>() {
            @Override
            public FeeChangedEventResponse apply(Log log) {
                EventValuesWithLog eventValues = extractEventParametersWithLog(FEECHANGED_EVENT, log);
                FeeChangedEventResponse typedResponse = new FeeChangedEventResponse();
                typedResponse.log = log;
                typedResponse.amount = (BigInteger) eventValues.getNonIndexedValues().get(0).getValue();
                return typedResponse;
            }
        });
    }

    public Flowable<FeeChangedEventResponse> feeChangedEventFlowable(DefaultBlockParameter startBlock, DefaultBlockParameter endBlock) {
        EthFilter filter = new EthFilter(startBlock, endBlock, getContractAddress());
        filter.addSingleTopic(EventEncoder.encode(FEECHANGED_EVENT));
        return feeChangedEventFlowable(filter);
    }

    public List<ReverseProposedEventResponse> getReverseProposedEvents(TransactionReceipt transactionReceipt) {
        List<EventValuesWithLog> valueList = extractEventParametersWithLog(REVERSEPROPOSED_EVENT, transactionReceipt);
        ArrayList<ReverseProposedEventResponse> responses = new ArrayList<ReverseProposedEventResponse>(valueList.size());
        for (EventValuesWithLog eventValues : valueList) {
            ReverseProposedEventResponse typedResponse = new ReverseProposedEventResponse();
            typedResponse.log = eventValues.getLog();
            typedResponse.reverse = (String) eventValues.getIndexedValues().get(0).getValue();
            typedResponse.name = (String) eventValues.getNonIndexedValues().get(0).getValue();
            responses.add(typedResponse);
        }
        return responses;
    }

    public Flowable<ReverseProposedEventResponse> reverseProposedEventFlowable(EthFilter filter) {
        return web3j.ethLogFlowable(filter).map(new io.reactivex.functions.Function<Log, ReverseProposedEventResponse>() {
            @Override
            public ReverseProposedEventResponse apply(Log log) {
                EventValuesWithLog eventValues = extractEventParametersWithLog(REVERSEPROPOSED_EVENT, log);
                ReverseProposedEventResponse typedResponse = new ReverseProposedEventResponse();
                typedResponse.log = log;
                typedResponse.reverse = (String) eventValues.getIndexedValues().get(0).getValue();
                typedResponse.name = (String) eventValues.getNonIndexedValues().get(0).getValue();
                return typedResponse;
            }
        });
    }

    public Flowable<ReverseProposedEventResponse> reverseProposedEventFlowable(DefaultBlockParameter startBlock, DefaultBlockParameter endBlock) {
        EthFilter filter = new EthFilter(startBlock, endBlock, getContractAddress());
        filter.addSingleTopic(EventEncoder.encode(REVERSEPROPOSED_EVENT));
        return reverseProposedEventFlowable(filter);
    }

    public List<ReverseConfirmedEventResponse> getReverseConfirmedEvents(TransactionReceipt transactionReceipt) {
        List<EventValuesWithLog> valueList = extractEventParametersWithLog(REVERSECONFIRMED_EVENT, transactionReceipt);
        ArrayList<ReverseConfirmedEventResponse> responses = new ArrayList<ReverseConfirmedEventResponse>(valueList.size());
        for (EventValuesWithLog eventValues : valueList) {
            ReverseConfirmedEventResponse typedResponse = new ReverseConfirmedEventResponse();
            typedResponse.log = eventValues.getLog();
            typedResponse.reverse = (String) eventValues.getIndexedValues().get(0).getValue();
            typedResponse.name = (String) eventValues.getNonIndexedValues().get(0).getValue();
            responses.add(typedResponse);
        }
        return responses;
    }

    public Flowable<ReverseConfirmedEventResponse> reverseConfirmedEventFlowable(EthFilter filter) {
        return web3j.ethLogFlowable(filter).map(new io.reactivex.functions.Function<Log, ReverseConfirmedEventResponse>() {
            @Override
            public ReverseConfirmedEventResponse apply(Log log) {
                EventValuesWithLog eventValues = extractEventParametersWithLog(REVERSECONFIRMED_EVENT, log);
                ReverseConfirmedEventResponse typedResponse = new ReverseConfirmedEventResponse();
                typedResponse.log = log;
                typedResponse.reverse = (String) eventValues.getIndexedValues().get(0).getValue();
                typedResponse.name = (String) eventValues.getNonIndexedValues().get(0).getValue();
                return typedResponse;
            }
        });
    }

    public Flowable<ReverseConfirmedEventResponse> reverseConfirmedEventFlowable(DefaultBlockParameter startBlock, DefaultBlockParameter endBlock) {
        EthFilter filter = new EthFilter(startBlock, endBlock, getContractAddress());
        filter.addSingleTopic(EventEncoder.encode(REVERSECONFIRMED_EVENT));
        return reverseConfirmedEventFlowable(filter);
    }

    public List<ReverseRemovedEventResponse> getReverseRemovedEvents(TransactionReceipt transactionReceipt) {
        List<EventValuesWithLog> valueList = extractEventParametersWithLog(REVERSEREMOVED_EVENT, transactionReceipt);
        ArrayList<ReverseRemovedEventResponse> responses = new ArrayList<ReverseRemovedEventResponse>(valueList.size());
        for (EventValuesWithLog eventValues : valueList) {
            ReverseRemovedEventResponse typedResponse = new ReverseRemovedEventResponse();
            typedResponse.log = eventValues.getLog();
            typedResponse.reverse = (String) eventValues.getIndexedValues().get(0).getValue();
            typedResponse.name = (String) eventValues.getNonIndexedValues().get(0).getValue();
            responses.add(typedResponse);
        }
        return responses;
    }

    public Flowable<ReverseRemovedEventResponse> reverseRemovedEventFlowable(EthFilter filter) {
        return web3j.ethLogFlowable(filter).map(new io.reactivex.functions.Function<Log, ReverseRemovedEventResponse>() {
            @Override
            public ReverseRemovedEventResponse apply(Log log) {
                EventValuesWithLog eventValues = extractEventParametersWithLog(REVERSEREMOVED_EVENT, log);
                ReverseRemovedEventResponse typedResponse = new ReverseRemovedEventResponse();
                typedResponse.log = log;
                typedResponse.reverse = (String) eventValues.getIndexedValues().get(0).getValue();
                typedResponse.name = (String) eventValues.getNonIndexedValues().get(0).getValue();
                return typedResponse;
            }
        });
    }

    public Flowable<ReverseRemovedEventResponse> reverseRemovedEventFlowable(DefaultBlockParameter startBlock, DefaultBlockParameter endBlock) {
        EthFilter filter = new EthFilter(startBlock, endBlock, getContractAddress());
        filter.addSingleTopic(EventEncoder.encode(REVERSEREMOVED_EVENT));
        return reverseRemovedEventFlowable(filter);
    }

    public List<ReservedEventResponse> getReservedEvents(TransactionReceipt transactionReceipt) {
        List<EventValuesWithLog> valueList = extractEventParametersWithLog(RESERVED_EVENT, transactionReceipt);
        ArrayList<ReservedEventResponse> responses = new ArrayList<ReservedEventResponse>(valueList.size());
        for (EventValuesWithLog eventValues : valueList) {
            ReservedEventResponse typedResponse = new ReservedEventResponse();
            typedResponse.log = eventValues.getLog();
            typedResponse.name = (byte[]) eventValues.getIndexedValues().get(0).getValue();
            typedResponse.owner = (String) eventValues.getIndexedValues().get(1).getValue();
            responses.add(typedResponse);
        }
        return responses;
    }

    public Flowable<ReservedEventResponse> reservedEventFlowable(EthFilter filter) {
        return web3j.ethLogFlowable(filter).map(new io.reactivex.functions.Function<Log, ReservedEventResponse>() {
            @Override
            public ReservedEventResponse apply(Log log) {
                EventValuesWithLog eventValues = extractEventParametersWithLog(RESERVED_EVENT, log);
                ReservedEventResponse typedResponse = new ReservedEventResponse();
                typedResponse.log = log;
                typedResponse.name = (byte[]) eventValues.getIndexedValues().get(0).getValue();
                typedResponse.owner = (String) eventValues.getIndexedValues().get(1).getValue();
                return typedResponse;
            }
        });
    }

    public Flowable<ReservedEventResponse> reservedEventFlowable(DefaultBlockParameter startBlock, DefaultBlockParameter endBlock) {
        EthFilter filter = new EthFilter(startBlock, endBlock, getContractAddress());
        filter.addSingleTopic(EventEncoder.encode(RESERVED_EVENT));
        return reservedEventFlowable(filter);
    }

    public List<TransferredEventResponse> getTransferredEvents(TransactionReceipt transactionReceipt) {
        List<EventValuesWithLog> valueList = extractEventParametersWithLog(TRANSFERRED_EVENT, transactionReceipt);
        ArrayList<TransferredEventResponse> responses = new ArrayList<TransferredEventResponse>(valueList.size());
        for (EventValuesWithLog eventValues : valueList) {
            TransferredEventResponse typedResponse = new TransferredEventResponse();
            typedResponse.log = eventValues.getLog();
            typedResponse.name = (byte[]) eventValues.getIndexedValues().get(0).getValue();
            typedResponse.oldOwner = (String) eventValues.getIndexedValues().get(1).getValue();
            typedResponse.newOwner = (String) eventValues.getIndexedValues().get(2).getValue();
            responses.add(typedResponse);
        }
        return responses;
    }

    public Flowable<TransferredEventResponse> transferredEventFlowable(EthFilter filter) {
        return web3j.ethLogFlowable(filter).map(new io.reactivex.functions.Function<Log, TransferredEventResponse>() {
            @Override
            public TransferredEventResponse apply(Log log) {
                EventValuesWithLog eventValues = extractEventParametersWithLog(TRANSFERRED_EVENT, log);
                TransferredEventResponse typedResponse = new TransferredEventResponse();
                typedResponse.log = log;
                typedResponse.name = (byte[]) eventValues.getIndexedValues().get(0).getValue();
                typedResponse.oldOwner = (String) eventValues.getIndexedValues().get(1).getValue();
                typedResponse.newOwner = (String) eventValues.getIndexedValues().get(2).getValue();
                return typedResponse;
            }
        });
    }

    public Flowable<TransferredEventResponse> transferredEventFlowable(DefaultBlockParameter startBlock, DefaultBlockParameter endBlock) {
        EthFilter filter = new EthFilter(startBlock, endBlock, getContractAddress());
        filter.addSingleTopic(EventEncoder.encode(TRANSFERRED_EVENT));
        return transferredEventFlowable(filter);
    }

    public List<DroppedEventResponse> getDroppedEvents(TransactionReceipt transactionReceipt) {
        List<EventValuesWithLog> valueList = extractEventParametersWithLog(DROPPED_EVENT, transactionReceipt);
        ArrayList<DroppedEventResponse> responses = new ArrayList<DroppedEventResponse>(valueList.size());
        for (EventValuesWithLog eventValues : valueList) {
            DroppedEventResponse typedResponse = new DroppedEventResponse();
            typedResponse.log = eventValues.getLog();
            typedResponse.name = (byte[]) eventValues.getIndexedValues().get(0).getValue();
            typedResponse.owner = (String) eventValues.getIndexedValues().get(1).getValue();
            responses.add(typedResponse);
        }
        return responses;
    }

    public Flowable<DroppedEventResponse> droppedEventFlowable(EthFilter filter) {
        return web3j.ethLogFlowable(filter).map(new io.reactivex.functions.Function<Log, DroppedEventResponse>() {
            @Override
            public DroppedEventResponse apply(Log log) {
                EventValuesWithLog eventValues = extractEventParametersWithLog(DROPPED_EVENT, log);
                DroppedEventResponse typedResponse = new DroppedEventResponse();
                typedResponse.log = log;
                typedResponse.name = (byte[]) eventValues.getIndexedValues().get(0).getValue();
                typedResponse.owner = (String) eventValues.getIndexedValues().get(1).getValue();
                return typedResponse;
            }
        });
    }

    public Flowable<DroppedEventResponse> droppedEventFlowable(DefaultBlockParameter startBlock, DefaultBlockParameter endBlock) {
        EthFilter filter = new EthFilter(startBlock, endBlock, getContractAddress());
        filter.addSingleTopic(EventEncoder.encode(DROPPED_EVENT));
        return droppedEventFlowable(filter);
    }

    public List<DataChangedEventResponse> getDataChangedEvents(TransactionReceipt transactionReceipt) {
        List<EventValuesWithLog> valueList = extractEventParametersWithLog(DATACHANGED_EVENT, transactionReceipt);
        ArrayList<DataChangedEventResponse> responses = new ArrayList<DataChangedEventResponse>(valueList.size());
        for (EventValuesWithLog eventValues : valueList) {
            DataChangedEventResponse typedResponse = new DataChangedEventResponse();
            typedResponse.log = eventValues.getLog();
            typedResponse.name = (byte[]) eventValues.getIndexedValues().get(0).getValue();
            typedResponse.key = (String) eventValues.getNonIndexedValues().get(0).getValue();
            typedResponse.plainKey = (String) eventValues.getNonIndexedValues().get(1).getValue();
            responses.add(typedResponse);
        }
        return responses;
    }

    public Flowable<DataChangedEventResponse> dataChangedEventFlowable(EthFilter filter) {
        return web3j.ethLogFlowable(filter).map(new io.reactivex.functions.Function<Log, DataChangedEventResponse>() {
            @Override
            public DataChangedEventResponse apply(Log log) {
                EventValuesWithLog eventValues = extractEventParametersWithLog(DATACHANGED_EVENT, log);
                DataChangedEventResponse typedResponse = new DataChangedEventResponse();
                typedResponse.log = log;
                typedResponse.name = (byte[]) eventValues.getIndexedValues().get(0).getValue();
                typedResponse.key = (String) eventValues.getNonIndexedValues().get(0).getValue();
                typedResponse.plainKey = (String) eventValues.getNonIndexedValues().get(1).getValue();
                return typedResponse;
            }
        });
    }

    public Flowable<DataChangedEventResponse> dataChangedEventFlowable(DefaultBlockParameter startBlock, DefaultBlockParameter endBlock) {
        EthFilter filter = new EthFilter(startBlock, endBlock, getContractAddress());
        filter.addSingleTopic(EventEncoder.encode(DATACHANGED_EVENT));
        return dataChangedEventFlowable(filter);
    }

    public List<NewOwnerEventResponse> getNewOwnerEvents(TransactionReceipt transactionReceipt) {
        List<EventValuesWithLog> valueList = extractEventParametersWithLog(NEWOWNER_EVENT, transactionReceipt);
        ArrayList<NewOwnerEventResponse> responses = new ArrayList<NewOwnerEventResponse>(valueList.size());
        for (EventValuesWithLog eventValues : valueList) {
            NewOwnerEventResponse typedResponse = new NewOwnerEventResponse();
            typedResponse.log = eventValues.getLog();
            typedResponse.old = (String) eventValues.getIndexedValues().get(0).getValue();
            typedResponse.current = (String) eventValues.getIndexedValues().get(1).getValue();
            responses.add(typedResponse);
        }
        return responses;
    }

    public Flowable<NewOwnerEventResponse> newOwnerEventFlowable(EthFilter filter) {
        return web3j.ethLogFlowable(filter).map(new io.reactivex.functions.Function<Log, NewOwnerEventResponse>() {
            @Override
            public NewOwnerEventResponse apply(Log log) {
                EventValuesWithLog eventValues = extractEventParametersWithLog(NEWOWNER_EVENT, log);
                NewOwnerEventResponse typedResponse = new NewOwnerEventResponse();
                typedResponse.log = log;
                typedResponse.old = (String) eventValues.getIndexedValues().get(0).getValue();
                typedResponse.current = (String) eventValues.getIndexedValues().get(1).getValue();
                return typedResponse;
            }
        });
    }

    public Flowable<NewOwnerEventResponse> newOwnerEventFlowable(DefaultBlockParameter startBlock, DefaultBlockParameter endBlock) {
        EthFilter filter = new EthFilter(startBlock, endBlock, getContractAddress());
        filter.addSingleTopic(EventEncoder.encode(NEWOWNER_EVENT));
        return newOwnerEventFlowable(filter);
    }

    @Deprecated
    public static SimpleRegistry load(String contractAddress, Web3j web3j, Credentials credentials, BigInteger gasPrice, BigInteger gasLimit) {
        return new SimpleRegistry(contractAddress, web3j, credentials, gasPrice, gasLimit);
    }

    @Deprecated
    public static SimpleRegistry load(String contractAddress, Web3j web3j, TransactionManager transactionManager, BigInteger gasPrice, BigInteger gasLimit) {
        return new SimpleRegistry(contractAddress, web3j, transactionManager, gasPrice, gasLimit);
    }

    public static SimpleRegistry load(String contractAddress, Web3j web3j, Credentials credentials, ContractGasProvider contractGasProvider) {
        return new SimpleRegistry(contractAddress, web3j, credentials, contractGasProvider);
    }

    public static SimpleRegistry load(String contractAddress, Web3j web3j, TransactionManager transactionManager, ContractGasProvider contractGasProvider) {
        return new SimpleRegistry(contractAddress, web3j, transactionManager, contractGasProvider);
    }

    public static RemoteCall<SimpleRegistry> deploy(Web3j web3j, Credentials credentials, ContractGasProvider contractGasProvider) {
        return deployRemoteCall(SimpleRegistry.class, web3j, credentials, contractGasProvider, BINARY, "");
    }

    @Deprecated
    public static RemoteCall<SimpleRegistry> deploy(Web3j web3j, Credentials credentials, BigInteger gasPrice, BigInteger gasLimit) {
        return deployRemoteCall(SimpleRegistry.class, web3j, credentials, gasPrice, gasLimit, BINARY, "");
    }

    public static RemoteCall<SimpleRegistry> deploy(Web3j web3j, TransactionManager transactionManager, ContractGasProvider contractGasProvider) {
        return deployRemoteCall(SimpleRegistry.class, web3j, transactionManager, contractGasProvider, BINARY, "");
    }

    @Deprecated
    public static RemoteCall<SimpleRegistry> deploy(Web3j web3j, TransactionManager transactionManager, BigInteger gasPrice, BigInteger gasLimit) {
        return deployRemoteCall(SimpleRegistry.class, web3j, transactionManager, gasPrice, gasLimit, BINARY, "");
    }

    public static class DrainedEventResponse extends BaseEventResponse {
        public BigInteger amount;
    }

    public static class FeeChangedEventResponse extends BaseEventResponse {
        public BigInteger amount;
    }

    public static class ReverseProposedEventResponse extends BaseEventResponse {
        public String reverse;

        public String name;
    }

    public static class ReverseConfirmedEventResponse extends BaseEventResponse {
        public String reverse;

        public String name;
    }

    public static class ReverseRemovedEventResponse extends BaseEventResponse {
        public String reverse;

        public String name;
    }

    public static class ReservedEventResponse extends BaseEventResponse {
        public byte[] name;

        public String owner;
    }

    public static class TransferredEventResponse extends BaseEventResponse {
        public byte[] name;

        public String oldOwner;

        public String newOwner;
    }

    public static class DroppedEventResponse extends BaseEventResponse {
        public byte[] name;

        public String owner;
    }

    public static class DataChangedEventResponse extends BaseEventResponse {
        public byte[] name;

        public String key;

        public String plainKey;
    }

    public static class NewOwnerEventResponse extends BaseEventResponse {
        public String old;

        public String current;
    }
}

```