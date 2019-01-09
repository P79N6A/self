```bash
# 当前服务器
bash api.sh command=listVirtualMachines response=json listAll=true | jq .listvirtualmachinesresponse.virtualmachine[0]

# 当前公网ipid
bash api.sh command=listVirtualMachines response=json listAll=true | jq .listvirtualmachinesresponse.virtualmachine[0].publicipid | sed 's/"//g'

# 当前服务器的networkid
bash api.sh command=listVirtualMachines response=json listAll=true | jq .listvirtualmachinesresponse.virtualmachine[0].nic[0].networkid | sed 's/"//g'

# 当前domainid
bash api.sh command=listVirtualMachines response=json listAll=true | jq .listvirtualmachinesresponse.virtualmachine[0].domainid | sed 's/"//g'

# 当前zonename
$(bash api.sh command=listVirtualMachines response=json listAll=true | jq .listvirtualmachinesresponse.virtualmachine[0].zonename | sed 's/"//g'

# 释放ip
bash api.sh command=disassociateIpAddress response=json listAll=true id=ipid

# ip是否正在使用
bash api.sh command=listPublicIpAddresses response=json listAll=true id=ipid | jq .listpublicipaddressesresponse.publicipaddress[0].isstaticnat

# 获取可用ip
bash api.sh command=listPublicIpAddresses response=json listAll=true associatedNetworkId=531a9ff3-c70f-46b5-8609-95d9ad214b9b

# 生成可用ip
# 此处获取生成的ip的id
bash api.sh command=associateIpAddress response=json networkid=531a9ff3-c70f-46b5-8609-95d9ad214b9b domainid=f167238f-5f35-4d14-a5ab-5cd8dc5fc144 account=gmo83 | jq .associateipaddressresponse.id
```
