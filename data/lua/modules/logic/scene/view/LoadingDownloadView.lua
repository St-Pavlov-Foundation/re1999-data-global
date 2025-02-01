module("modules.logic.scene.view.LoadingDownloadView", package.seeall)

slot0 = class("LoadingDownloadView", BaseView)

function slot0.onInitView(slot0)
	slot0._progressBar = SLFramework.UGUI.SliderWrap.GetWithPath(slot0.viewGO, "progressBar")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._txtPercent = gohelper.findChildText(slot0.viewGO, "bottom_text/#txt_percent")
	slot0._txtWarn = gohelper.findChildText(slot0.viewGO, "bottom_text/#txt_actualnum")
	slot0._txtDescribe = gohelper.findChildText(slot0.viewGO, "describe_text/#txt_describe")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "describe_text/#txt_describe/title/#txt_title")
	slot0._txtTitleEn = gohelper.findChildText(slot0.viewGO, "describe_text/#txt_describe/title/#txt_title_en")

	slot0:_setLoadingItem()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(GameSceneMgr.instance, SceneEventName.ShowDownloadInfo, slot0._showDownloadInfo, slot0)
end

function slot0.onClose(slot0)
	gohelper.setActive(slot0.viewGO, false)
	slot0:removeEventCb(GameSceneMgr.instance, SceneEventName.ShowDownloadInfo, slot0._showDownloadInfo, slot0)
	slot0._simagebg:UnLoadImage()
end

function slot0._showDownloadInfo(slot0, slot1, slot2, slot3)
	slot0:setPercent(slot1)
	slot0:setProgressMsg(slot2)
	slot0:setWarnningMsg(slot3)
end

function slot0._getRandomCO(slot0, slot1)
	for slot6, slot7 in ipairs(slot1) do
		slot2 = 0 + slot7.weight
	end

	for slot7, slot8 in ipairs(slot1) do
		if math.floor(math.random() * slot2) < slot8.weight then
			return slot8
		else
			slot3 = slot3 - slot8.weight
		end
	end

	return slot1[math.random(1, #slot1)]
end

function slot0._setLoadingItem(slot0)
	slot2 = slot0:_getRandomCO(booterLoadingConfig())
	slot0._txtDescribe.text = slot2.desc
	slot0._txtTitle.text = slot2.title
	slot0._txtTitleEn.text = slot2.titleen

	slot0:_showDownloadInfo(0, luaLang("voice_package_update"))
	slot0._simagebg:LoadImage(ResUrl.getLoadingBg("full/originbg"))
end

function slot0.show(slot0, slot1, slot2, slot3)
	slot0:setPercent(slot1)
	slot0:setProgressMsg(slot2)
	slot0:setWarnningMsg(slot3)
end

function slot0.setPercent(slot0, slot1)
	slot0._progressBar:SetValue(slot1)
end

function slot0.setProgressMsg(slot0, slot1)
	slot0._txtPercent.text = slot1 and slot1 or ""
end

function slot0.setWarnningMsg(slot0, slot1)
	slot0._txtWarn.text = slot1 and slot1 or ""
end

return slot0
