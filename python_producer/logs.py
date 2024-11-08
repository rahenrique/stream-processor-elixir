import time, datetime, uuid

LOG_TEMPLATES = [
    {
        "date": datetime.date.today().isoformat(),
        "eventtime": str(datetime.datetime.today().timestamp()),
        "sessionid": "398284089",
        "type": "traffic",
        "srccountry": "Brazil",
        "log_management": {"data_source": "10.100.252.141"},
        "host": "10.100.252.141",
        "dstfamily": "Virtual Machine",
        "level": "notice",
        "dsthwvendor": "VMware",
        "tags": ["fortigate"],
        "log_id": str(uuid.uuid4()),
        "devname": "FWDEVICE-12345-001",
        "@timestamp": f"{datetime.datetime.today().isoformat()}Z",
        "time": time.strftime("%X")
    },
    {
        "deviceVendor": "FORCEPOINT",
        "deviceReceiptTime": datetime.datetime.today().strftime("%b %d %Y %H:%M:%S"),
        "deviceExternalId": "FWVBOR-SAAS-001 node 1",
        "source_ip": "10.101.128.3",
        "destination_ip": "10.17.80.193",
        "deviceInboundInterface": "0",
        "deviceProduct": "Firewall",
        "host_ip": "100.127.253.6",
        "destinationServiceName": "Syslog",
        "deviceCustomString3": "2098497.1",
        "deviceCustomString2": "2101109.2",
        "deviceVersion": "6.8.6",
        "deviceEventClassId": "70021",
        "tags": ["forcepoint"],
        "log_id": str(uuid.uuid4()),
        "deviceFacility": "Packet Filtering"
    },
    {
        "log_id": str(uuid.uuid4()),
        "@timestamp": f"{datetime.datetime.today().isoformat()}Z",
        "log_management": {"tenant": {"id": "IDTENANT1234567890"}},
        "port": 39472,
        "@version": "1",
        "host": "10.100.250.13",
        "message": "SOME LOG MESSAGE EXAMPLE ThreadPool Starvation Alert",
        "tags": ["vmware"]
    },
    {
        "agent": {
            "name": "SVWVVIXAP16",
            "id": str(uuid.uuid4()),
            "ephemeral_id": str(uuid.uuid4()),
            "type": "winlogbeat",
            "version": "8.0.1"
        },
        "winlog": {
            "task": "Kerberos Service Ticket Operations",
            "keywords": [
                "Audit Success"
            ],
            "provider_guid": f"{str(uuid.uuid4())}",
            "channel": "Security",
            "api": "wineventlog",
            "event_data": {
                "Status": "0x0",
                "TicketEncryptionType": "0x12",
                "LogonGuid": f"{str(uuid.uuid4())}",
                "ServiceName": "SVWVVIXAP98$",
                "TicketOptions": "0x40810000",
                "IpAddress": "::ffff:192.168.16.70",
                "IpPort": "17171",
                "ServiceSid": "S-1-5-21-1070969303-904401691-1989892110-9648",
                "TargetUserName": "RAH-DC-BACKUP@CLIENTE.LOCAL",
                "TransmittedServices": "-",
                "TargetDomainName": "CLIENTE.LOCAL"
            },
            "provider_name": "Microsoft-Windows-Security-Auditing",
            "opcode": "Info"
        },
        "message": "A Kerberos service ticket was requested.",
        "event": {
            "code": "4769",
            "provider": "Microsoft-Windows-Security-Auditing",
            "kind": "event",
            "created": f"{datetime.datetime.today().isoformat()}Z",
            "action": "Kerberos Service Ticket Operations",
            "outcome": "success"
        },
        "customer": {}
    },
    {
        "log_id": str(uuid.uuid4()),
        "@timestamp": f"{datetime.datetime.today().isoformat()}Z",
        "@version": "1",
        "host": "10.100.254.204",
        "message": "SOME LOG MESSAGE",
        "tags": ["pfsense"]
    },
    {
        "deviceCustomString3Label": "full_request",
        "deviceCustomIPv6Address4Label": "ip_address_intelligence",
        "deviceReceiptTime": datetime.datetime.today().strftime("%b %d %Y %H:%M:%S"),
        "source_ip": "187.108.17.28",
        "destination_ip": "10.101.251.102",
        "syslog": "<134>Feb 16 15:17:27 waf-as-a-service001.teste.com.br",
        "deviceCustomString6Label": "geo_location",
        "deviceExternalId": "0",
        "deviceCustomNumber2Label": "violation_rating",
        "deviceAddress": "172.31.200.198",
        "deviceCustomString5Label": "x_forwarded_for_header_value",
        "requestUrl": "/snoa/views/Inbox/Inbox.xhtml",
        "source_port": "54358",
        "@timestamp": f"{datetime.datetime.today().isoformat()}Z"
    },
    {
        "accountName": "RAH",
        "deviceVendor": "SentinelOne",
        "siteName": "Desktops",
        "syslog": f'<14>{datetime.datetime.today().strftime("%Y-%M-%d %H:%M:%S")} sentinel',
        "deviceReceiptTime": f'#arcsightDate({datetime.datetime.today().strftime("%b %d %Y %H:%M:%S")})',
        "log_management": {"tenant": {}},
        "host": "54.145.186.126",
        "osName": "Windows 10 Pro",
        "tags": ["sentinelone"],
        "deviceEventCategory": "SystemEvent",
        "log_id": str(uuid.uuid4()),
        "@timestamp": f"{datetime.datetime.today().isoformat()}Z",
        "name": "Agent disabled - Machine NBVIX13963"
    }
]
