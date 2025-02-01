module("modules.logic.ressplit.work.ResSplitExportWork", package.seeall)

slot0 = class("ResSplitExportWork", BaseWork)

function slot0.onStart(slot0, slot1)
	slot0.result = {}

	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, "explore/", true)
	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, "atlassrc/ui_modules/explore/", true)
	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, "ui/viewres/explore/", true)
	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, "singlebg/explore/", true)
	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, "atlassrc/ui_spriteset/explore/", true)
	slot0:_filter(ResSplitEnum.Path)
	slot0:_filter(ResSplitEnum.Folder)
	slot0:_filter(ResSplitEnum.SinglebgFolder)
	slot0:_filter(ResSplitEnum.AudioBank)
	slot0:_filter(ResSplitEnum.CommonAudioBank)
	slot0:_filter(ResSplitEnum.Video)
	slot0:_filter(ResSplitEnum.AudioWem)
	slot0:_filter(ResSplitEnum.InnerAudioWem)
	slot0:_filter(ResSplitEnum.InnerRoomAB)
	slot0:_filter(ResSplitEnum.OutRoomAB)
	slot0:_filter(ResSplitEnum.OutSceneAB)
	slot0:_filter(ResSplitEnum.InnerSceneAB)

	slot3 = io.open(ResSplitEnum.ExportConfigPath, "w")

	slot3:write(tostring(string.gsub(cjson.encode(slot0.result), "\\/", "/")))
	slot3:close()
	slot0:onDone(true)
	logNormal("ResSplit Done!")
end

function slot0._filter(slot0, slot1)
	slot2 = {}

	if ResSplitModel.instance:getExcludeDic(slot1) then
		for slot7, slot8 in pairs(slot3) do
			if slot8 == true then
				slot10 = string.find(SLFramework.FileHelper.GetFileName(slot7, true), "%.")

				if slot7 == "" or not slot10 or slot10 > 1 then
					slot2[slot7] = true
				end
			end
		end

		slot0.result[slot1] = slot2
	end

	logNormal(slot1, tabletool.len(slot2))
end

return slot0
