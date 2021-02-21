
content = inspec.profile.file("output.json")
params = JSON.parse(content)

aws_vpc_id = params['vpc_id']['value']
public_subnets = params['public_subnets']['value']
web_sec_grp_id = params['web_sec_grp_id']['value']
web_elb_sec_grp_id = params['web_elb_sec_grp_id']['value']
web_asg_id = params['web_asg_id']['value']
web_elb_id = params['web_elb_id']['value']

describe aws_vpc(aws_vpc_id) do
  its('state') { should eq 'available' }
end

control 'aws-subnets-loop' do

  impact 1.0
  title 'Loop across AWS VPC Subnets resource for detail.'
  
  aws_subnets.where public_subnets.each do |subnet|
      describe aws_subnet(subnet) do
          it                      { should be_available }
          its ('vpc_id')          { should eq aws_vpc_id }
      end
  end
end

describe aws_vpc(web_sec_grp_id) do
  its('state') { should eq 'available' }
end

describe aws_vpc(web_elb_sec_grp_id) do
  its('state') { should eq 'available' }
end

describe aws_vpc(web_asg_id) do
  its('state') { should eq 'available' }
end

describe aws_vpc(web_elb_id) do
  its('state') { should eq 'available' }
end
