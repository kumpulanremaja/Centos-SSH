#!/bin/bash
# Created by Hidessh
# Modified by Hidessh
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300
