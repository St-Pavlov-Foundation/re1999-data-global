module("modules.logic.prototest.model.ProtoTestFileModel", package.seeall)

slot0 = class("ProtoTestFileModel", ListScrollModel)

function slot0.refreshFileList(slot0)
	SLFramework.FileHelper.EnsureDir(ProtoFileHelper.DirPath)

	slot2 = slot0:getList()

	for slot6 = 1, SLFramework.FileHelper.GetDirFilePaths(ProtoFileHelper.DirPath).Length do
		slot8 = SLFramework.FileHelper.GetFileName(slot1[slot6 - 1], false)

		if not slot2[slot6] then
			table.insert(slot2, ProtoTestFileMO.New())
		end

		slot9.id = slot6
		slot9.filePath = slot7
		slot9.fileName = slot8
	end

	slot0:setList(slot2)
end

slot0.instance = slot0.New()

return slot0
