#!usr/bin/python3
# -*- coding:utf-8 -*-

"""
异步I/O操作-asyncio模块
version:1.0
date:2019\6\1
"""

import asyncio

async def wget(host):
    print("wget %s ..." % host)
    connect = asyncio.open_connection(host,80)
    #异步方式等待连接结果
    reader,writer = await connect
    header = "Get / HTTP/1.0\r\nHost: %s\r\n\r\n" % host
    writer.write(header.encode("utf-8"))
    #异步I/O方式执行操作
    await writer.drain()
    while True:
        #异步I/O方式执行读操作
        line = await reader.readline()
        if line == b'\r\n':
            break
        print("%s header > %s" % (host,line.decode("utf-8").rstrip()))
    writer.close()



loop= asyncio.get_event_loop()
#通过生成式语法创建一个装了3个协程的列表
hosts_list = ["www.sina.com","www.sohu.com","www.163.com"]
tasks=[wget(host) for host in hosts_list]
#下面的方法将异步I/O操作放入EventLoop直到执行完毕
loop.run_until_complete(asyncio.wait(tasks))
loop.close()