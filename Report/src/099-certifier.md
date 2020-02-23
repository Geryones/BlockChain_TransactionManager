## Certifier \label{app_certifier}

### Certifier.sol

```
//! Certifier contract, used by service transaction.
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


interface Certifier {
	event Confirmed(address indexed who);
	event Revoked(address indexed who);

	function certified(address _who)
		external
		view
		returns (bool);
}
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

### SimpleCertifier.sol

```
//! The SimpleCertifier contract, used by service transaction.
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

import "./Certifier.sol";
import "./Owned.sol";


contract SimpleCertifier is Owned, Certifier {
	struct Certification {
		bool active;
	}

	mapping (address => Certification) certs;

	// So that the server posting puzzles doesn't have access to the ETH.
	address public delegate = msg.sender;

	modifier onlyDelegate {
		require(msg.sender == delegate);
		_;
	}

	modifier onlyCertified(address _who) {
		require(certs[_who].active);
		_;
	}

	function certify(address _who)
		external
		onlyDelegate
	{
		certs[_who].active = true;
		emit Confirmed(_who);
	}

	function revoke(address _who)
		external
		onlyDelegate
		onlyCertified(_who)
	{
		certs[_who].active = false;
		emit Revoked(_who);
	}

	function setDelegate(address _new)
		external
		onlyOwner
	{
		delegate = _new;
	}

	function certified(address _who)
		external
		view
		returns (bool)
	{
		return certs[_who].active;
	}
}
```

### Java-Wrapper für SimpleCertifier \label{sec_app_simpleCertifier_java}

```
package ch.brugg.fhnw.btm.contracts;

import io.reactivex.Flowable;
import org.web3j.abi.EventEncoder;
import org.web3j.abi.TypeReference;
import org.web3j.abi.datatypes.*;
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
 * String used to generate this file:
 * web3j solidity generate -b .\src\main\resources\solidity\Certifier\out\SimpleCertifier.bin -a .\src\main\resources\solidity\Certifier\out\SimpleCertifier.abi -o .\src\main\java -p io.kauri.tutorials.java_ethereum.contracts
 */
@SuppressWarnings("rawtypes")
public class SimpleCertifier extends Contract {
    public static final String BINARY = "Platzhalter für BinaryCode";

    public static final String FUNC_SETOWNER = "setOwner";

    public static final String FUNC_CERTIFY = "certify";

    public static final String FUNC_REVOKE = "revoke";

    public static final String FUNC_OWNER = "owner";

    public static final String FUNC_DELEGATE = "delegate";

    public static final String FUNC_SETDELEGATE = "setDelegate";

    public static final String FUNC_CERTIFIED = "certified";

    public static final Event CONFIRMED_EVENT = new Event("Confirmed", 
            Arrays.<TypeReference<?>>asList(new TypeReference<Address>(true) {}));
    ;

    public static final Event REVOKED_EVENT = new Event("Revoked", 
            Arrays.<TypeReference<?>>asList(new TypeReference<Address>(true) {}));
    ;

    public static final Event NEWOWNER_EVENT = new Event("NewOwner", 
            Arrays.<TypeReference<?>>asList(new TypeReference<Address>(true) {}, new TypeReference<Address>(true) {}));
    ;

    @Deprecated
    protected SimpleCertifier(String contractAddress, Web3j web3j, Credentials credentials, BigInteger gasPrice, BigInteger gasLimit) {
        super(BINARY, contractAddress, web3j, credentials, gasPrice, gasLimit);
    }

    protected SimpleCertifier(String contractAddress, Web3j web3j, Credentials credentials, ContractGasProvider contractGasProvider) {
        super(BINARY, contractAddress, web3j, credentials, contractGasProvider);
    }

    @Deprecated
    protected SimpleCertifier(String contractAddress, Web3j web3j, TransactionManager transactionManager, BigInteger gasPrice, BigInteger gasLimit) {
        super(BINARY, contractAddress, web3j, transactionManager, gasPrice, gasLimit);
    }

    protected SimpleCertifier(String contractAddress, Web3j web3j, TransactionManager transactionManager, ContractGasProvider contractGasProvider) {
        super(BINARY, contractAddress, web3j, transactionManager, contractGasProvider);
    }

    public RemoteFunctionCall<TransactionReceipt> setOwner(String _new) {
        final Function function = new Function(
                FUNC_SETOWNER, 
                Arrays.<Type>asList(new Address(160, _new)),
                Collections.<TypeReference<?>>emptyList());
        return executeRemoteCallTransaction(function);
    }

    public RemoteFunctionCall<TransactionReceipt> certify(String _who) {
        final Function function = new Function(
                FUNC_CERTIFY,
                Arrays.<Type>asList(new Address(160, _who)),
                Collections.<TypeReference<?>>emptyList());
        return executeRemoteCallTransaction(function);
    }

    public RemoteFunctionCall<TransactionReceipt> revoke(String _who) {
        final Function function = new Function(
                FUNC_REVOKE,
                Arrays.<Type>asList(new Address(160, _who)),
                Collections.<TypeReference<?>>emptyList());
        return executeRemoteCallTransaction(function);
    }

    public RemoteFunctionCall<String> owner() {
        final Function function = new Function(FUNC_OWNER,
                Arrays.<Type>asList(),
                Arrays.<TypeReference<?>>asList(new TypeReference<Address>() {}));
        return executeRemoteCallSingleValueReturn(function, String.class);
    }

    public RemoteFunctionCall<String> delegate() {
        final Function function = new Function(FUNC_DELEGATE,
                Arrays.<Type>asList(),
                Arrays.<TypeReference<?>>asList(new TypeReference<Address>() {}));
        return executeRemoteCallSingleValueReturn(function, String.class);
    }

    public RemoteFunctionCall<TransactionReceipt> setDelegate(String _new) {
        final Function function = new Function(
                FUNC_SETDELEGATE,
                Arrays.<Type>asList(new Address(160, _new)),
                Collections.<TypeReference<?>>emptyList());
        return executeRemoteCallTransaction(function);
    }

    public RemoteFunctionCall<Boolean> certified(String _who) {
        final Function function = new Function(FUNC_CERTIFIED,
                Arrays.<Type>asList(new Address(160, _who)),
                Arrays.<TypeReference<?>>asList(new TypeReference<Bool>() {}));
        return executeRemoteCallSingleValueReturn(function, Boolean.class);
    }

    public List<ConfirmedEventResponse> getConfirmedEvents(TransactionReceipt transactionReceipt) {
        List<EventValuesWithLog> valueList = extractEventParametersWithLog(CONFIRMED_EVENT, transactionReceipt);
        ArrayList<ConfirmedEventResponse> responses = new ArrayList<ConfirmedEventResponse>(valueList.size());
        for (EventValuesWithLog eventValues : valueList) {
            ConfirmedEventResponse typedResponse = new ConfirmedEventResponse();
            typedResponse.log = eventValues.getLog();
            typedResponse.who = (String) eventValues.getIndexedValues().get(0).getValue();
            responses.add(typedResponse);
        }
        return responses;
    }

    public Flowable<ConfirmedEventResponse> confirmedEventFlowable(EthFilter filter) {
        return web3j.ethLogFlowable(filter).map(new io.reactivex.functions.Function<Log, ConfirmedEventResponse>() {
            @Override
            public ConfirmedEventResponse apply(Log log) {
                EventValuesWithLog eventValues = extractEventParametersWithLog(CONFIRMED_EVENT, log);
                ConfirmedEventResponse typedResponse = new ConfirmedEventResponse();
                typedResponse.log = log;
                typedResponse.who = (String) eventValues.getIndexedValues().get(0).getValue();
                return typedResponse;
            }
        });
    }

    public Flowable<ConfirmedEventResponse> confirmedEventFlowable(DefaultBlockParameter startBlock, DefaultBlockParameter endBlock) {
        EthFilter filter = new EthFilter(startBlock, endBlock, getContractAddress());
        filter.addSingleTopic(EventEncoder.encode(CONFIRMED_EVENT));
        return confirmedEventFlowable(filter);
    }

    public List<RevokedEventResponse> getRevokedEvents(TransactionReceipt transactionReceipt) {
        List<EventValuesWithLog> valueList = extractEventParametersWithLog(REVOKED_EVENT, transactionReceipt);
        ArrayList<RevokedEventResponse> responses = new ArrayList<RevokedEventResponse>(valueList.size());
        for (EventValuesWithLog eventValues : valueList) {
            RevokedEventResponse typedResponse = new RevokedEventResponse();
            typedResponse.log = eventValues.getLog();
            typedResponse.who = (String) eventValues.getIndexedValues().get(0).getValue();
            responses.add(typedResponse);
        }
        return responses;
    }

    public Flowable<RevokedEventResponse> revokedEventFlowable(EthFilter filter) {
        return web3j.ethLogFlowable(filter).map(new io.reactivex.functions.Function<Log, RevokedEventResponse>() {
            @Override
            public RevokedEventResponse apply(Log log) {
                EventValuesWithLog eventValues = extractEventParametersWithLog(REVOKED_EVENT, log);
                RevokedEventResponse typedResponse = new RevokedEventResponse();
                typedResponse.log = log;
                typedResponse.who = (String) eventValues.getIndexedValues().get(0).getValue();
                return typedResponse;
            }
        });
    }

    public Flowable<RevokedEventResponse> revokedEventFlowable(DefaultBlockParameter startBlock, DefaultBlockParameter endBlock) {
        EthFilter filter = new EthFilter(startBlock, endBlock, getContractAddress());
        filter.addSingleTopic(EventEncoder.encode(REVOKED_EVENT));
        return revokedEventFlowable(filter);
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
    public static SimpleCertifier load(String contractAddress, Web3j web3j, Credentials credentials, BigInteger gasPrice, BigInteger gasLimit) {
        return new SimpleCertifier(contractAddress, web3j, credentials, gasPrice, gasLimit);
    }

    @Deprecated
    public static SimpleCertifier load(String contractAddress, Web3j web3j, TransactionManager transactionManager, BigInteger gasPrice, BigInteger gasLimit) {
        return new SimpleCertifier(contractAddress, web3j, transactionManager, gasPrice, gasLimit);
    }

    public static SimpleCertifier load(String contractAddress, Web3j web3j, Credentials credentials, ContractGasProvider contractGasProvider) {
        return new SimpleCertifier(contractAddress, web3j, credentials, contractGasProvider);
    }

    public static SimpleCertifier load(String contractAddress, Web3j web3j, TransactionManager transactionManager, ContractGasProvider contractGasProvider) {
        return new SimpleCertifier(contractAddress, web3j, transactionManager, contractGasProvider);
    }

    public static RemoteCall<SimpleCertifier> deploy(Web3j web3j, Credentials credentials, ContractGasProvider contractGasProvider) {
        return deployRemoteCall(SimpleCertifier.class, web3j, credentials, contractGasProvider, BINARY, "");
    }

    @Deprecated
    public static RemoteCall<SimpleCertifier> deploy(Web3j web3j, Credentials credentials, BigInteger gasPrice, BigInteger gasLimit) {
        return deployRemoteCall(SimpleCertifier.class, web3j, credentials, gasPrice, gasLimit, BINARY, "");
    }

    public static RemoteCall<SimpleCertifier> deploy(Web3j web3j, TransactionManager transactionManager, ContractGasProvider contractGasProvider) {
        return deployRemoteCall(SimpleCertifier.class, web3j, transactionManager, contractGasProvider, BINARY, "");
    }

    @Deprecated
    public static RemoteCall<SimpleCertifier> deploy(Web3j web3j, TransactionManager transactionManager, BigInteger gasPrice, BigInteger gasLimit) {
        return deployRemoteCall(SimpleCertifier.class, web3j, transactionManager, gasPrice, gasLimit, BINARY, "");
    }

    public static class ConfirmedEventResponse extends BaseEventResponse {
        public String who;
    }

    public static class RevokedEventResponse extends BaseEventResponse {
        public String who;
    }

    public static class NewOwnerEventResponse extends BaseEventResponse {
        public String old;

        public String current;
    }


}

```

