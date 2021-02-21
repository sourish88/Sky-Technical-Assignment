
content = inspec.profile.file("output.json")
params = JSON.parse(content)

vpc_id = params['vpc_id']['value']
web_sec_grp_id = params['web_sec_grp_id']['value']
web_elb_sec_grp_id = params['web_elb_sec_grp_id']['value']
web_asg_id = params['web_asg_id']['value']
web_elb_id = params['web_elb_id']['value']

describe aws_vpc(vpc_id) do
  its('state') { should eq 'available' }
end

describe aws_security_group(web_sec_grp_id) do
  it { should exist }
end

describe aws_security_group(web_elb_sec_grp_id) do
  it { should exist }
end

describe aws_auto_scaling_group(web_asg_id) do
  its('state') { should eq 'available' }
end

describe aws_elb(web_elb_id) do
  it { should exist }
end