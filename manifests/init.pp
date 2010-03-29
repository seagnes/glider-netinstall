define glider_netinstall($ip,
		$subnet,
		$netmask,
		$gw,
		$dns,
		$static_nodes_file,
		$os_mirror_base_url,
		$root_password_hash
		){

import "glider-netinstall/*"
include "puppet_server"

		$pxe_kernel_location = "http://$ip/glider/$operatingsystem/$operatingsystemrelease/os/$architecture/images/pxeboot"

		dhcp_server{dhcp:
			ip => $ip,
			subnet => $subnet,
			netmask => $netmask,
			gw => $gw,
			dns => $dns,
			tftp => $ip,
			static_nodes_file => $static_nodes_file
		}

		tftp_server{tftp:
			pxe_kernel_location => "$pxe_kernel_location",
			kickstart_url => "http://$ip/glider/glider.ks",
			root_password_hash => "$root_password_hash"
		}
		clone_repo{rpm:
			repo_base_url => $os_mirror_base_url
		}

}


