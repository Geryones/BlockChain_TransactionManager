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