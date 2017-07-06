table "asset" do
	column "id", :key, :as => :integer
	column "asset_type", :string
	column "path", :string
end

table "developer" do
	column "id", :key, :as => :integer
	column "name_id", :integer, :references => "name" 
	column "email_id", :integer, :references => "email"
end

table "discipline" do
	column "id", :key, :as => :integer
	column "discipline_name", :string
	column "discipline_id", :string
end

table "disciplines_assets" do
	column "discipline_id", :integer, :references => "discipline"
	column "assetid", :integer, :references => "asset"
end

table "email" do
	column "id", :key, :as => :integer
	column "email", :string
end

table "experiment" do
	column "id", :key, :as => :integer
	column "exp_name", :string
	column "exp_id", :string
	column "overview", :string
	column "intstatus_id", :integer, :references => "integration_status"
	column "lb_id", :integer, :references => "lab"
	column "institute_id", :integer, :references => "institute"
	column "discipline_id", :integer, :references => "discipline"
end

table "experiments_assets" do
	column "experimentid", :integer, :references => "experiment"
	column "assetid", :integer, :references => "asset"
end

table "experiments_developers" do
	column "experiment_id", :integer, :references => "experiment"
	column "developer_id", :integer, :references => "developer"
end

table "experiments_hosting_info" do
	column "experimentid", :integer, :references => "experiment"
	column "hosting_infoid", :integer, :references => "hosting_info"
end

table "experiments_sections" do
	column "experiment_id", :integer, :references => "experiment"
	column "section_id", :integer, :references => "section"
end

table "hosting_info" do
	column "id", :key, :as => :integer
	column "hosting_status", :string
	column "hosted_url", :string
	column "hosted_on", :string
end

table "institute" do
	column "id", :key, :as => :integer
	column "institute_name", :string
	column "institute_id", :string
end

table "institutes_assets" do
	column "institute_id", :integer, :references => "institute"
	column "assetid", :integer, :references => "asset"
end

table "institutes_labs" do
	column "institute_id", :integer, :references => "institute"
	column "lab_id", :integer, :references => "lab"
end

table "integration_status" do
	column "id", :key, :as => :integer
	column "integration_level", :integer
end

table "lab" do
	column "id", :key, :as => :integer
	column "lab_id", :string
	column "lab_name", :string
	column "overview", :string
	column "institute_id", :integer, :references => "institute"
	column "discipline_id", :integer, :references => "discipline"
	column "integration_status_id", :integer, :references => "integration_status"
end

table "lab_assets" do
	column "labid", :integer, :references => "lab"
	column "assetid", :integer, :references => "asset"
end

table "lab_developers" do
	column "labid", :integer, :references => "lab"
	column "developer_id", :integer, :references => "developer"
end

table "lab_experiments" do
	column "labid", :integer, :references => "lab"
	column "expid", :integer, :references => "experiment"
end

table "lab_hosting_info" do
	column "labid", :integer, :references => "lab"
	column "hosting_infoid", :integer, :references => "hosting_info"
end

table "labs_sections" do
	column "labid", :integer, :references => "lab"
	column "section_id", :integer, :references => "section"
end

table "name" do
	column "id", :key, :as => :integer
	column "name", :string
end

table "section" do
	column "id", :key, :as => :integer
	column "name", :string
end

