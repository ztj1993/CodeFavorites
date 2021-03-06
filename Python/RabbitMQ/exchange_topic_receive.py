# -*- coding: utf-8 -*-
# Author: Ztj

from common import channel

channel.exchange_declare(exchange='exchange_topic_exchange', exchange_type='topic')

result = channel.queue_declare(exclusive=True)
queue_name = result.method.queue

channel.queue_bind(exchange='exchange_topic_exchange', queue=queue_name, routing_key='one.*')


def callback(ch, method, properties, body):
    print(" [x] Received %r" % body)


channel.basic_consume(callback, queue=queue_name, no_ack=True)

print(' [*] Waiting for messages. To exit press CTRL+C')
channel.start_consuming()
