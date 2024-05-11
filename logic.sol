// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SurvivalGame {
    address public player1;
    address public player2;
    address public currentPlayer;
    bool public isDaytime;

    // 地图的结构
    struct Tile {
        uint8 owner; // 0 表示无所有者，1 表示玩家1，2 表示玩家2
        uint8 technology; // 科技水平
        uint8 military; // 军事力量
    }

    // 地图的二维数组
    Tile[][] public map;

    constructor() {
        player1 = msg.sender;
        player2 = address(0); // 初始时玩家2地址为空
        currentPlayer = player1;
        isDaytime = true;

        // 初始化地图
        map = new Tile[][](10); // 假设地图是10x10的
        for (uint8 i = 0; i < 10; i++) {
            map[i] = new Tile[](10);
            for (uint8 j = 0; j < 10; j++) {
                map[i][j].owner = 0; // 初始时无所有者
                map[i][j].technology = 0; // 初始科技水平为0
                map[i][j].military = 0; // 初始军事力量为0
            }
        }
    }

    modifier onlyPlayer() {
        require(msg.sender == player1 || msg.sender == player2, "Only players can perform this action");
        _;
    }

    modifier onlyCurrentPlayer() {
        require(msg.sender == currentPlayer, "It's not your turn");
        _;
    }

    // 扩张领地
    function expandTerritory(uint8 x, uint8 y) external onlyCurrentPlayer {
        require(map[x][y].owner == 0, "This tile already has an owner");
        map[x][y].owner = uint8(msg.sender);
    }

    // 种地
    function cultivateLand(uint8 x, uint8 y) external onlyCurrentPlayer {
        require(map[x][y].owner == uint8(msg.sender), "You don't own this tile");
        if (isDaytime) {
            map[x][y].technology += 1; // 白天提升科技
        } else {
            map[x][y].military -= 1; // 夜晚降低军事
        }
    }

    // 提升军事
    function boostMilitary(uint8 x, uint8 y) external onlyCurrentPlayer {
        require(map[x][y].owner == uint8(msg.sender), "You don't own this tile");
        map[x][y].military += 1;
    }

    // 提升科技
    function boostTechnology(uint8 x, uint8 y) external onlyCurrentPlayer {
        require(map[x][y].owner == uint8(msg.sender), "You don't own this tile");
        map[x][y].technology += 1;
    }

    // 切换玩家
    function togglePlayer() external onlyPlayer {
        currentPlayer = (currentPlayer == player1) ? player2 : player1;
    }

    // 切换时间（白天和夜晚）
    function toggleTime() external onlyPlayer {
        isDaytime = !isDaytime;
    }
}
