module("modules.logic.main.view.MainBannerView", package.seeall)

slot0 = class("MainBannerView", BaseView)

function slot0.onInitView(slot0)
	slot0._clickbag = slot0:getUserDataTb_()
	slot0._iconbag = slot0:getUserDataTb_()
	slot0._bgbag = slot0:getUserDataTb_()
	slot0._banners = {}
	slot0._willDisapearBanner = 0

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
	slot0:_clearAllClick()
end

function slot0._bannerOnClick(slot0, slot1)
	if string.split(MainBannerConfig.instance:getbannerCO(tonumber(slot1)).vanishingRule, "#")[1] == "2" then
		MainBannerModel.instance:addNotShowid(slot1)
		slot0:_refreshBanner()
	end

	if slot2.jumpId ~= 0 then
		GameFacade.jump(slot2.jumpId)
	end
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, slot0._onCloseFullView, slot0)
	slot0:_refreshBanner()
end

function slot0._setBanner(slot0, slot1)
	slot2 = MainBannerConfig.instance:getBannersCo()
	slot3 = MainBannerConfig.instance:getNowBanner(slot1)

	for slot7 = 1, 3 do
		slot0:_clearClick(slot7)
		gohelper.setActive(gohelper.findChild(slot0.viewGO, "left/#go_banners/banner" .. slot7), false)
	end

	slot0._banners = {}

	for slot7, slot8 in pairs(slot3) do
		if slot8 ~= nil then
			slot9 = gohelper.findChild(slot0.viewGO, "left/#go_banners/banner" .. slot7)

			gohelper.setActive(slot9, true)

			slot11 = gohelper.findChildSingleImage(slot9, "bannericon")

			slot11:LoadImage(ResUrl.getBannerIcon(slot2[slot8].icon))
			table.insert(slot0._iconbag, slot11)
			table.insert(slot0._clickbag, {
				SLFramework.UGUI.UIClickListener.Get(slot9),
				slot8
			})
			table.insert(slot0._banners, slot2[slot8].id)
		end
	end

	for slot7, slot8 in pairs(slot0._clickbag) do
		slot8[1]:AddClickListener(slot0._bannerOnClick, slot0, slot8[2])
	end
end

function slot0._setTimer(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._refreshBanner, slot0)

	if MainBannerConfig.instance:getNearTime(slot1, slot0._banners) ~= nil then
		TaskDispatcher.runDelay(slot0._refreshBanner, slot0, slot2.time - slot1 + 3)

		slot0._willDisapearBanner = slot2.id
	end
end

function slot0._disapearBanner(slot0)
	for slot4, slot5 in pairs(slot0._banners) do
		if slot5 == slot0._willDisapearBanner then
			slot0:_clearClick(slot4)
			gohelper.setActive(gohelper.findChild(slot0.viewGO, "left/banners/banner" .. slot4), false)
		end
	end

	slot0:_setTimer(ServerTime.now())
end

function slot0._refreshBanner(slot0)
	slot1 = ServerTime.now()

	slot0:_setBanner(slot1)
	slot0:_setTimer(slot1)
end

function slot0._clearClick(slot0, slot1)
	if slot0._clickbag and slot0._clickbag[slot1] then
		slot0._clickbag[slot1][1]:RemoveClickListener()
	end
end

function slot0._clearAllClick(slot0)
	if slot0._clickbag then
		for slot4, slot5 in pairs(slot0._clickbag) do
			slot5[1]:RemoveClickListener()
		end
	end
end

function slot0._onCloseFullView(slot0, slot1)
	if not ViewMgr.instance:hasOpenFullView() then
		slot0:_refreshBanner()
	end
end

function slot0.onClose(slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, slot0._onCloseFullView, slot0)
end

function slot0.onDestroyView(slot0)
	slot4 = slot0

	TaskDispatcher.cancelTask(slot0._refreshBanner, slot4)

	for slot4, slot5 in pairs(slot0._iconbag) do
		slot5:UnLoadImage()
	end

	for slot4, slot5 in pairs(slot0._bgbag) do
		slot5:UnLoadImage()
	end
end

return slot0
