module("modules.logic.versionactivity2_5.autochess.mgr.AutoChessEffectMgr", package.seeall)

slot0 = class("AutoChessEffectMgr")

function slot0.init(slot0)
	slot0.pathList = {}
	slot0.resList = {}
	slot0.path2AssetItemDic = {}
	slot0.path2PointListDic = {}
end

function slot0.getEffectRes(slot0, slot1, slot2)
	if slot0.path2AssetItemDic[AutoChessHelper.getEffectUrl(slot1)] then
		gohelper.addChild(slot2, gohelper.clone(slot4:GetResource(slot3)))
	else
		if not slot0.path2PointListDic[slot3] then
			slot0.path2PointListDic[slot3] = {}
		end

		table.insert(slot0.path2PointListDic[slot3], slot2)
		table.insert(slot0.pathList, slot3)
		loadAbAsset(slot3, false, slot0.onLoadCallback, slot0)
	end
end

function slot0.onLoadCallback(slot0, slot1)
	if not slot0.resList then
		return
	end

	table.insert(slot0.resList, slot1)

	slot2 = slot1.ResPath

	if slot1.IsLoadSuccess then
		slot1:Retain()

		slot0.path2AssetItemDic[slot2] = slot1

		if slot0.path2PointListDic[slot2] then
			for slot8, slot9 in ipairs(slot3) do
				if not gohelper.isNil(slot9) then
					gohelper.addChild(slot9, gohelper.clone(slot1:GetResource(slot2)))
				end
			end

			tabletool.clear(slot0.path2PointListDic[slot2])
		end
	else
		logError(string.format("异常:自走棋特效加载失败%s", slot2))
	end
end

function slot0.dispose(slot0)
	if slot0.pathList and #slot0.resList < #slot0.pathList then
		for slot4, slot5 in ipairs(slot0.pathList) do
			removeAssetLoadCb(slot5, slot0.onLoadCallback, slot0)
		end
	end

	if slot0.resList then
		for slot4, slot5 in ipairs(slot0.resList) do
			slot5:Release()
			rawset(slot0.resList, slot4, nil)
		end
	end

	slot0.pathList = nil
	slot0.resList = nil
	slot0.path2AssetItemDic = nil
	slot0.path2PointListDic = nil
end

slot0.instance = slot0.New()

return slot0
