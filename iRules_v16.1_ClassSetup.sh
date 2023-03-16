#   (_)  __ \     | |          
#    _| |__) |   _| | ___  ___ 
#   | |  _  / | | | |/ _ \/ __|
#   | | | \ \ |_| | |  __/\__ \
#   |_|_|  \_\__,_|_|\___||___/
#                              
#                              

# Create Load-balancing pools
tmsh create /ltm pool /Common/P1 members add { 172.16.20.1:http }
tmsh create /ltm pool /Common/P2 members add { 172.16.20.2:http }
tmsh create /ltm pool /Common/P3 members add { 172.16.20.3:http }
tmsh create /ltm pool /Common/P4 members add { 172.16.20.4:http }
tmsh create /ltm pool /Common/P5 members add { 172.16.20.5:http }
tmsh create /ltm pool /Common/P1SSL members add { 172.16.20.1:https }
tmsh create /ltm pool /Common/P2SSL members add { 172.16.20.2:https }
tmsh create /ltm pool /Common/P3SSL members add { 172.16.20.3:https }
tmsh create /ltm pool /Common/P4SSL members add { 172.16.20.4:https }
tmsh create /ltm pool /Common/P5SSL members add { 172.16.20.5:https }
tmsh create /ltm pool /Common/P1-3 members add { 172.16.20.1:http 172.16.20.2:http 172.16.20.3:http }
tmsh create /ltm pool /Common/P1-4 members add { 172.16.20.1:http 172.16.20.2:http 172.16.20.3:http 172.16.20.4:http }
tmsh create /ltm pool /Common/P1-5 members add { 172.16.20.1:http 172.16.20.2:http 172.16.20.3:http 172.16.20.4:http 172.16.20.5:http }
tmsh create /ltm pool /Common/P1-3SSL members add { 172.16.20.1:https 172.16.20.2:https 172.16.20.3:https }
tmsh create /ltm pool /Common/P1-4SSL members add { 172.16.20.1:https 172.16.20.2:https 172.16.20.3:https 172.16.20.4:https }
tmsh create /ltm pool /Common/P1-5SSL members add { 172.16.20.1:https 172.16.20.2:https 172.16.20.3:https 172.16.20.4:https 172.16.20.5:https }

# Pool for Lab - LTM17 host
tmsh create /ltm pool /Common/P_Lab9 members add { 10.10.17.209:http }

# Create SNAT pools
tmsh create /ltm snatpool /Common/SP150 members add { 10.10.1.150 172.16.1.150 }
tmsh create /ltm snatpool /Common/SP151 members add { 10.10.1.151 172.16.1.151 } 

# Create Virtual Servers
tmsh create /ltm virtual /Common/VS202 destination 10.10.1.202:http ip-protocol tcp profiles add { tcp } pool /Common/P1-3
tmsh create /ltm virtual /Common/VS203 destination 10.10.1.203:http ip-protocol tcp profiles add { tcp http }
tmsh create /ltm virtual /Common/VS204 destination 10.10.1.204:http ip-protocol tcp profiles add { tcp http } pool /Common/P4
tmsh create /ltm virtual /Common/VS205 destination 10.10.1.205:http ip-protocol tcp profiles add { tcp http } pool /Common/P5
tmsh create /ltm virtual /Common/VS206 destination 10.10.1.206:http ip-protocol tcp profiles add { tcp http } pool /Common/P1
tmsh create /ltm virtual /Common/VS207 destination 10.10.1.207:http ip-protocol tcp profiles add { tcp http }
tmsh create /ltm virtual /Common/VS208 destination 10.10.1.208:http ip-protocol tcp profiles add { tcp http } pool /Common/P1-3
tmsh create /ltm virtual /Common/VS209 destination 10.10.1.209:http ip-protocol tcp profiles add { tcp http } pool /Common/P_Lab9
tmsh create /ltm virtual /Common/VS210 destination 10.10.1.210:http ip-protocol tcp profiles add { tcp http } pool /Common/P1
tmsh create /ltm virtual /Common/VS211 destination 10.10.1.211:http ip-protocol tcp profiles add { tcp http } pool /Common/P1-3

tmsh create /ltm virtual /Common/VS202SSL destination 10.10.1.202:https ip-protocol tcp profiles add { tcp http clientssl serverssl-insecure-compatible } pool /Common/P1-3SSL
tmsh create /ltm virtual /Common/VS207SSL destination 10.10.1.207:https ip-protocol tcp profiles add { tcp http clientssl serverssl-insecure-compatible }
tmsh create /ltm virtual /Common/VS211SSL destination 10.10.1.211:https ip-protocol tcp profiles add { tcp http clientssl serverssl-insecure-compatible } pool /Common/P1-3SSL
