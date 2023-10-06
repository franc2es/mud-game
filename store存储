// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 导入Store合约
import "@mudgen/store/contracts/Store.sol";

contract SurvivalGame {
    Store private store; // 声明一个私有的Store实例

    constructor(address _storeAddress) {
        store = Store(_storeAddress); // 初始化Store实例，传入Store合约的地址
    }

    // 设置游戏中的状态数据
    function setGameData(string memory key, uint256 value) external {
        bytes32[] memory keyTuple = new bytes32[](1);
        keyTuple[0] = keccak256(abi.encodePacked(key));

        // 使用Store设置数据
        store.setField("MyTable", keyTuple, 0, abi.encodePacked(value));
    }

    // 获取游戏状态数据
    function getGameData(string memory key) external view returns (uint256) {
        bytes32[] memory keyTuple = new bytes32[](1);
        keyTuple[0] = keccak256(abi.encodePacked(key));

        // 使用Store获取数据
        bytes memory data = store.getField("MyTable", keyTuple, 0);
        return uint256(abi.decode(data, (uint256)));
    }

    // 其余的游戏逻辑和函数保持不变
    // ...
}
