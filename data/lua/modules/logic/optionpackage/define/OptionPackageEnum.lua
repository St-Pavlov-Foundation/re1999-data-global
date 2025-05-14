module("modules.logic.optionpackage.define.OptionPackageEnum", package.seeall)

local var_0_0 = _M

var_0_0.SourceType = {
	OptResVoice = 3,
	Voice = 1,
	OptRes = 2
}
var_0_0.UpdateState = {
	NeedUpdate = 3,
	NotDownload = 1,
	AlreadyLatest = 4,
	InDownload = 2
}
var_0_0.Package = {
	VersionActivity = "opveract"
}
var_0_0.NeedPackLangList = {
	"res",
	"media"
}
var_0_0.NeedPackLangDict = {}

for iter_0_0, iter_0_1 in ipairs(var_0_0.NeedPackLangList) do
	var_0_0.NeedPackLangDict[iter_0_1] = true
end

var_0_0.PackageNameList = {}
var_0_0.HasPackageNameDict = {}

for iter_0_2, iter_0_3 in pairs(var_0_0.Package) do
	var_0_0.HasPackageNameDict[iter_0_3] = true

	table.insert(var_0_0.PackageNameList, iter_0_3)
end

return var_0_0
