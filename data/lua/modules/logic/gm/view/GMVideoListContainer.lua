module("modules.logic.gm.view.GMVideoListContainer", package.seeall)

slot0 = class("GMVideoListContainer", BaseViewContainer)
slot0.listModel = ListScrollModel.New()

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "rightviewport"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "rightviewport/item"
	slot1.cellClass = GMVideoListItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 2
	slot1.cellWidth = 500
	slot1.cellHeight = 90
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 0
	slot1.startSpace = 0
	slot2 = {}

	table.insert(slot2, LuaListScrollView.New(uv0.listModel, slot1))

	return slot2
end

function slot0.onContainerInit(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnClose")

	slot0._btnClose:AddClickListener(slot0.closeThis, slot0)
	uv0.listModel:clear()

	slot1 = {}

	if SLFramework.FrameworkSettings.IsEditor then
		for slot8 = 0, SLFramework.FileHelper.GetDirFilePaths(SLFramework.FrameworkSettings.AssetRootDir .. "/videos/").Length - 1 do
			if string.sub(slot3[slot8], -4) == ".mp4" then
				if not string.find(slot9, "Android") then
					table.insert(slot1, {
						video = SLFramework.FileHelper.GetFileName(slot9, false)
					})
				end
			end
		end
	elseif SLFramework.FileHelper.GetDirFilePaths(SLFramework.FrameworkSettings.PersistentResRootDir .. "/videos/") then
		for slot7 = 0, slot3.Length - 1 do
			if string.sub(slot3[slot7], -4) == ".mp4" then
				table.insert(slot1, {
					video = SLFramework.FileHelper.GetFileName(slot8, false)
				})
			end
		end
	end

	table.sort(slot1, function (slot0, slot1)
		return slot0.video < slot1.video
	end)
	uv0.listModel:addList(slot1)
end

function slot0.onContainerDestroy(slot0)
	slot0._btnClose:RemoveClickListener()
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
