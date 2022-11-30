# 
ErlangDemo

## Description

1. 个人练习代码，仅仅作为个人记录，代码质量不做任何保证
2. 部分文件可能会涉及到开源版权问题，请自行处理
3. 本demo离商业化差距太大，如直接使用，本人概不负责

## 代码结构

| 目录           | 说明              |
|:-------------|:----------------|
| config       | 服务器配置文件         |
| data         | 数据文件            |
| etc          | etc文件           |
| include      | 头文件目录           |
| scripts      | 脚本目录            |
| sql          | 数据目录            |
| src          | 源码目录            |
| var          | Mnesia目录        |
| cvLoggerLogs | Logger日志目录      |
| cvSaslLogs   | SASL滚动日志目录      |
| cvSelfLogs   | 游戏运行时日志目录       |

## 编译运行

### Centos7.8

进入源码根目录

```
make all_rebuild
sudo sh gamectl start # start方式启动

```



## 本项目的运行环境

1. VMware14 && centos7.8
2. Erlang:OTP23.1
3. Rebar:2.6.4


