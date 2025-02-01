module("modules.logic.optionpackage.define.OptionPackageEnum", package.seeall)

slot0 = _M
slot0.SourceType = {
	OptResVoice = 3,
	Voice = 1,
	OptRes = 2
}
slot0.UpdateState = {
	NeedUpdate = 3,
	NotDownload = 1,
	AlreadyLatest = 4,
	InDownload = 2
}
slot0.Package = {
	VersionActivity = "opveract"
}
slot0.NeedPackLangList = {
	"res",
	"media"
}
slot0.NeedPackLangDict = {}

for slot4, slot5 in ipairs(slot0.NeedPackLangList) do
	slot0.NeedPackLangDict[slot5] = true
end

slot0.PackageNameList = {}
slot0.HasPackageNameDict = {}

for slot4, slot5 in pairs(slot0.Package) do
	slot0.HasPackageNameDict[slot5] = true

	table.insert(slot0.PackageNameList, slot5)
end

return slot0
