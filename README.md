# TerraformTemplate
My first template for IBM Cloud Schematics (Terraform)

# Understanding the configuration file components
variable.ssh_key
A variable declaration for the name of the SSH key that you uploaded to your IBM Cloud account. You enter the value for your variable when you create your workspace in IBM Cloud Schematics.

variable.resource_group
A variable declaration for the name of the resource group that you want to use for your VPC resources.
provider.generation	Enter 1 to provision VPC on Classic infrastructure resources.

provider.region
Enter the VPC region where you want to create your VPC infrastructure resources. Make sure to use the same region that you used when you uploaded your SSH key. To find a list of supported VPC regions, run ibmcloud is regions.

locals.BASENAME
Enter a name that you want to append to the name of all VPC infrastructure resources that you create with this configuration file.

locals.ZONE
Enter a supported VPC zone where you want to create your resources. To find available zones, run ibmcloud is zones.

resource.ibm_is_vpc.name
Enter a name for your VPC. In this example, you use locals.BASENAME to create part of the name. For example, if your base name is schematics, the name of your VPC is set to schematics-vpc. Keep in mind that the name of your VPC must be unique within your IBM Cloud account.

resource.ibm_is_security_group.name	Enter a name for the security group that you create for your VPC. In this example, you use locals.BASENAME to create part of the name. For example, if your base name is schematics, the name of your security group is set to schematics-sg1.

resource.ibm_is_security_group.vpc
Enter the ID of the VPC for which you want to create the security group. In this example, you reference the ID of the VPC that you create with the ibm_is_vpc resource in the same configuration file.

resource.ibm_is_security_group_rule.group
Enter the ID of the security group for which you want to create a security group rule. In this example, you reference the ID of the security group that you create with the ibm_is_security_group resource in the same configuration file.

resource.ibm_is_security_group_rule.direction
Specify if the security group rule is applied to incoming or outgoing network traffic. Choose inbound to specify a rule for incoming network traffic, and outbound to specify a rule for outgoing network traffic.

resource.ibm_is_security_group_rule.remote
Enter the IP address range, for which the security group rule is applied. In this example, 0.0.0.0/0 allows incoming network traffic from all IP addresses.

resource.ibm_is_security_group_rule.tcp
Enter the TCP port range that you want to open in your security group rule. If you want to open up a single port, enter the same port number in port_min and port_max.

resource.ibm_is_subnet.name
Enter a name for your subnet. In this example, you use locals.BASENAME to create part of the name. For example, if your base name is schematics, the name of your subnet is set to schematics-subnet1.

resource.ibm_is_subnet.vpc
Enter the ID of the VPC for which you want to create the subnet. In this example, you reference the ID of the VPC that you create with the ibm_is_vpc resource in the same configuration file.

resource.ibm_is_subnet.zone
Enter the zone in which you want to create the subnet. In this example, you use locals.ZONE as the name for your zone.

resource.ibm_is_subnet.
total_ipv4_address_count
Enter the number of IPv4 IP addresses that you want to have in your subnet.

data.ibm_is_image.name
Enter the name of the operating system that you want to install on your VPC virtual server instance. In this example, you retrieve the ID of the operating system so that you can use the ID when you create the VPC virtual server instance. For supported image names, run ibmcloud is images.

data.ibm_is_ssh_key.name	
Enter the name of the SSH key that you uploaded to your IBM Cloud account. In this example, you reference a variable for the SSH key name so that you don't have to enter the SSH key name into your Terraform configuration file directly. You can enter the values for all variable declarations when you create your workspace in Schematics. The 
data.ibm_is_ssh_key Terraform resource is used to retrieve the ID of an existing SSH key so that you can use this ID when you create your VPC virtual server instance.

data.ibm_resource_group.name	
Enter the name of the resource group that you want to use for your VPC resources. In this example, you retrieve the name from the resource group variable data.ibm_resource_group. Make sure that you have the right permissions to provision IBM Cloud resources in a resource group.

resource.ibm_is_instance.name	
Enter the name of the VPC virtual server instance that you want to create. In this example, you use locals.BASENAME to create part of the name. For example, if your base name is test, the name of your VPC virtual server instance is set to test-vsi1.

resource.ibm_is_instance.resource_group
Enter the ID of the resource group that you want to use for your VPC virtual server instance. In this example, you retrieve the ID from the ibm_resource_group data source of this configuration file. Terraform uses the name of the resource group that you define in your data source object to look up information about the resource group in your IBM Cloud account.

resource.ibm_is_instance.vpc	
Enter the ID of the VPC in which you want to create the VPC virtual server instance. In this example, you reference the ID of the VPC that you create with the ibm_is_vpc resource in the same configuration file.

resource.ibm_is_instance.zone	
Enter the zone in which you want to create the VPC virtual server instance. In this example, you use locals.ZONE as the name for your zone.

resource.ibm_is_instance.keys	
Enter the UUID of the SSH key that you uploaded to your IBM Cloud account. In this example, you retrieve the UUID from the ibm_is_ssh_key data source of this configuration file. Terraform uses the name of the SSH key that you define in your data source object to look up information about the SSH key in your IBM Cloud account.

resource.ibm_is_instance.image
Enter the ID of the image that represents the operating system that you want to install on your VPC virtual server instance. In this example, you retrieve the ID from the ibm_is_image data source of this configuration file. Terraform uses the name of the image that you define in your data source object to look up information about the image in the IBM Cloud infrastructure portfolio.

resource.ibm_is_instance.profile
Enter the name of the profile that you want to use for your VPC virtual server instance. For supported profiles, run ibmcloud is instance-profiles.
resource.ibm_is_instance.

primary_network_interface.subnet
Enter the ID of the subnet that you want to use for your VPC virtual server instance. In this example, you use the ibm_is_subnet resource in this configuration file to retrieve the ID of the subnet.
resource.ibm_is_instance.

primary_network_interface.security_groups
Enter the ID of the security group that you want to apply to your VPC virtual server instance. In this example, you use the ibm_is_security_group resource in this configuration file to retrieve the ID of the security group.

resource.ibm_is_floating_ip.name
Enter a name for your floating IP resource. In this example, you use locals.BASENAME to create part of the name. For example, if your base name is schematics, the name of your floating IP resource is set to schematics-fip1.

resource.ibm_is_floating_ip.target
Enter the ID of the network interface where you want to allocate the floating IP addresses. In this example, you use the ibm_is_instance resource to retrieve the ID of the primary network interface.

output.ssh_command.value
Build the SSH command that you need to run to connect to your VPC virtual server instance. In this example, you use the ibm_is_floating_ip resource to retrieve the floating IP address that is assigned to your VPC virtual server instance.
