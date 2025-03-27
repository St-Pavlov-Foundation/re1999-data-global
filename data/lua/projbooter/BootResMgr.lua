module("projbooter.BootResMgr", package.seeall)

slot0 = class("BootResMgr")
slot0.OriginBgPath = "bootres/prefabs/originbg.prefab"
slot0.LoadingViewPath = "bootres/prefabs/loadingview.prefab"
slot0.MsgBoxViewPath = "bootres/prefabs/msgboxview.prefab"
slot0.NoticeViewPath = "bootres/prefabs/noticeview.prefab"
slot0.VoiceViewPath = "bootres/prefabs/voicedownloadview.prefab"
slot0.VersionViewPath = "bootres/prefabs/versionview.prefab"
slot0.AdaptionBgViewPath = "bootres/prefabs/adaptionbg.prefab"
slot0.FontPath = "Font"

function slot0.ctor(slot0)
	math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 7)))

	slot0._loadedCount = 0
	slot0._orginBgRoot = UnityEngine.GameObject.Find("UIRoot/OriginBg")
	slot0._popupTopRoot = UnityEngine.GameObject.Find("UIRoot/POPUP_TOP")
	slot0._topRoot = UnityEngine.GameObject.Find("UIRoot/TOP")
	slot0._msgRoot = UnityEngine.GameObject.Find("UIRoot/MESSAGE")
	slot0._allRes = {
		imgs = {}
	}
	slot0._hasShowIndexs = {}
	slot1 = slot0:_getRandomCO()
	slot2 = string.format("bootres/textures/%s.png", slot1.bg)
	slot0._allRes.imgs[slot2] = {
		path = slot2,
		config = slot1
	}
	slot0._allRes.prefabs = {
		[uv0.OriginBgPath] = {
			path = uv0.OriginBgPath,
			layer = slot0._orginBgRoot
		},
		[uv0.LoadingViewPath] = {
			path = uv0.LoadingViewPath,
			layer = slot0._topRoot
		},
		[uv0.MsgBoxViewPath] = {
			path = uv0.MsgBoxViewPath,
			layer = slot0._msgRoot
		},
		[uv0.NoticeViewPath] = {
			path = uv0.NoticeViewPath,
			layer = slot0._topRoot
		},
		[uv0.VoiceViewPath] = {
			path = uv0.VoiceViewPath,
			layer = slot0._popupTopRoot
		},
		[uv0.VersionViewPath] = {
			path = uv0.VersionViewPath,
			layer = slot0._popupTopRoot
		},
		[uv0.AdaptionBgViewPath] = {
			path = uv0.AdaptionBgViewPath,
			layer = slot0._topRoot
		}
	}
end

function slot0.getAutoMaskGo(slot0)
	return slot0._allRes.prefabs[uv0.AutoMaskPath].go
end

function slot0.getLoadingViewGo(slot0)
	return slot0._allRes.prefabs[uv0.LoadingViewPath].go
end

function slot0.getMsgBoxGo(slot0)
	return slot0._allRes.prefabs[uv0.MsgBoxViewPath].go
end

function slot0.getNoticeViewGo(slot0)
	return slot0._allRes.prefabs[uv0.NoticeViewPath].go
end

function slot0.getVoiceViewGo(slot0)
	return slot0._allRes.prefabs[uv0.VoiceViewPath].go
end

function slot0.getVersionViewGo(slot0)
	return slot0._allRes.prefabs[uv0.VersionViewPath].go
end

function slot0.getAdaptionViewGo(slot0)
	return slot0._allRes.prefabs[uv0.AdaptionBgViewPath].go
end

function slot0.getOriginBgGo(slot0)
	return slot0._allRes.prefabs[uv0.OriginBgPath].go
end

function slot0.getLoadingBg(slot0, slot1, slot2, slot3)
	if slot1 == 1 then
		for slot7, slot8 in pairs(slot0._allRes.imgs) do
			if slot2 then
				slot2(slot3, slot8.texture, slot8.config)
			end

			return
		end
	else
		if not slot0._allRes.imgs[string.format("bootres/textures/%s.png", slot0:_getRandomCO().bg)] then
			slot0._allRes.imgs[slot5] = {}
		end

		slot0._allRes.imgs[slot5].path = slot5
		slot0._allRes.imgs[slot5].config = slot4

		if not slot0._allRes.imgs[slot5].texture then
			loadAbAsset(slot0._allRes.imgs[slot5].path, false, function (slot0)
				if not uv0._allRes then
					return
				end

				uv0._allRes.imgs[uv1].texture = slot0:GetResource()

				if uv2 then
					uv2(uv3, uv0._allRes.imgs[uv1].texture, uv0._allRes.imgs[uv1].config)
				end
			end)
		elseif slot2 then
			slot2(slot3, slot0._allRes.imgs[slot5].texture, slot0._allRes.imgs[slot5].config)
		end
	end
end

function slot0._getRandomCO(slot0)
	for slot6, slot7 in ipairs(booterLoadingConfig()) do
		if not slot0._hasShowIndexs[slot6] then
			slot2 = 0 + slot7.weight
		end
	end

	for slot7, slot8 in ipairs(slot1) do
		if not slot0._hasShowIndexs[slot7] then
			if math.floor(math.random() * slot2) < slot8.weight then
				slot0._hasShowIndexs[slot7] = true

				return slot8
			else
				slot3 = slot3 - slot8.weight
			end
		end
	end

	slot0._hasShowIndexs = {}
	slot4 = math.random(1, #slot1)
	slot0._hasShowIndexs[slot4] = true

	return slot1[slot4]
end

function slot0.startLoading(slot0, slot1, slot2)
	logNormal("BootResMgr.startLoading loadedCb = " .. tostring(slot1) .. " cbObj = " .. tostring(slot2))

	slot0._loadedCb = slot1
	slot0._cbObj = slot2

	loadAbAsset(BootLangEnum.LangFont[GameConfig:GetCurLangType()] or BootLangEnum.Font.b_hwzs, false, slot0._onloadedFont, slot0)
end

function slot0._onloadedFont(slot0, slot1)
	if slot1.IsLoadSuccess then
		BootLangFontMgr.instance:init(slot1:GetResource())
	end

	for slot5, slot6 in pairs(slot0._allRes.prefabs) do
		slot0._loadedCount = slot0._loadedCount + 1

		loadAbAsset(slot5, false, slot0._onPrefabLoaded, slot0)
	end

	for slot5, slot6 in pairs(slot0._allRes.imgs) do
		slot0._loadedCount = slot0._loadedCount + 1

		loadAbAsset(slot6.path, false, slot0._onImgLoaded, slot0)
	end
end

function slot0._onImgLoaded(slot0, slot1)
	if slot1.IsLoadSuccess then
		slot0._loadedCount = slot0._loadedCount - 1
		slot0._allRes.imgs[slot1.ResPath].texture = slot1:GetResource()

		slot0:_checkResLoadFinished()
	end
end

function slot0._onPrefabLoaded(slot0, slot1)
	if slot1.IsLoadSuccess then
		if uv0.AdaptionBgViewPath == slot1.ResPath then
			GameAdaptionBgMgr.instance:onAssetResLoaded(slot1)
		end

		slot0._loadedCount = slot0._loadedCount - 1

		UnityEngine.GameObject.Instantiate(slot1:GetResource()):SetActive(false)
		slot3.transform:SetParent((slot0._allRes.prefabs[slot1.ResPath].layer or slot0._topRoot).transform, false)

		slot0._allRes.prefabs[slot1.ResPath].go = slot3

		slot0:_checkResLoadFinished()
	end
end

function slot0._checkResLoadFinished(slot0)
	if slot0._loadedCount == 0 then
		logNormal("BootResMgr onloaded, 所有的启动UI资源都加载完成了！")

		if slot0._loadedCb then
			slot0._loadedCb(slot0._cbObj)
		end
	end
end

function slot0.dispose(slot0)
	if slot0._disposed then
		return
	end

	BootLangFontMgr.instance:dispose()
	BootLoadingView.instance:dispose()
	BootMsgBox.instance:dispose()
	BootNoticeView.instance:dispose()
	BootVoiceView.instance:dispose()
	BootVersionView.instance:dispose()

	if slot0._allRes then
		for slot4, slot5 in pairs(slot0._allRes.prefabs) do
			UnityEngine.GameObject.Destroy(slot5.go)
		end

		slot0._allRes = nil
	end

	slot0._disposed = true
end

slot0.instance = slot0.New()

return slot0
