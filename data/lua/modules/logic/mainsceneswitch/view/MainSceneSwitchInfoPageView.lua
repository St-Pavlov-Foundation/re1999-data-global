module("modules.logic.mainsceneswitch.view.MainSceneSwitchInfoPageView", package.seeall)

slot0 = class("MainSceneSwitchInfoPageView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobg1 = gohelper.findChild(slot0.viewGO, "#go_bg1")
	slot0._gobg2 = gohelper.findChild(slot0.viewGO, "#go_bg2")
	slot0._simageFullBG1 = gohelper.findChildSingleImage(slot0._gobg1, "img")
	slot0._simageFullBG2 = gohelper.findChildSingleImage(slot0._gobg2, "img")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._switchTime = CommonConfig.instance:getConstNum(ConstEnum.SceneSwitchPageTime)

	slot0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.ShowPreviewSceneInfo, slot0._onShowSceneInfo, slot0)
end

function slot0._onShowSceneInfo(slot0, slot1)
	slot0:_initPage(slot1)
end

function slot0._clearPage(slot0)
	gohelper.setActive(slot0._simageFullBG1, false)
	gohelper.setActive(slot0._simageFullBG2, false)
	TaskDispatcher.cancelTask(slot0._switchPage, slot0)
	TaskDispatcher.cancelTask(slot0._switchPageFinish, slot0)
end

function slot0._initPage(slot0, slot1)
	gohelper.setActive(slot0._simageFullBG1, true)
	gohelper.setActive(slot0._simageFullBG2, true)

	if not slot0._page1 then
		slot0._page1 = {
			img = slot0._simageFullBG1,
			pageGo = slot0._gobg1,
			animator = slot0._gobg1:GetComponent("Animator")
		}
		slot0._page2 = {
			img = slot0._simageFullBG2,
			pageGo = slot0._gobg2,
			animator = slot0._gobg2:GetComponent("Animator")
		}
	end

	slot0._previews = lua_scene_switch.configDict[slot1].previews
	slot0._pageIndex = 1

	slot0:_updatePage()
	TaskDispatcher.cancelTask(slot0._switchPageFinish, slot0)
	TaskDispatcher.cancelTask(slot0._switchPage, slot0)
	TaskDispatcher.runDelay(slot0._switchPage, slot0, slot0._switchTime)
end

function slot0._switchPage(slot0)
	TaskDispatcher.runDelay(slot0._switchPageFinish, slot0, MainSceneSwitchEnum.PageSwitchTime)
	slot0._page1.animator:Play("close", 0, 0)
	slot0._page2.animator:Play("open", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.MainSceneSkin.play_ui_main_glitter)
end

function slot0._switchPageFinish(slot0)
	slot0._page2 = slot0._page1
	slot0._page1 = slot0._page2
	slot0._pageIndex = slot0._pageIndex + 1

	if slot0._pageIndex > #slot0._previews then
		slot0._pageIndex = 1
	end

	slot0:_updatePage()
	TaskDispatcher.runDelay(slot0._switchPage, slot0, slot0._switchTime)
end

function slot0._updatePage(slot0)
	slot0:_updateOnePage(slot0._page1.img, slot0._pageIndex, 0)
	slot0:_updateOnePage(slot0._page2.img, slot0._pageIndex + 1, 0)
	slot0._page1.animator:Play("open", 0, 0)
	gohelper.setAsFirstSibling(slot0._page2.pageGo)
	slot0._page2.animator:Play("open", 0, 0)
end

function slot0._updateOnePage(slot0, slot1, slot2, slot3)
	if slot2 > #slot0._previews then
		slot2 = 1
	end

	slot1:LoadImage(ResUrl.getMainSceneSwitchIcon(string.format("mainsceneswitch_randombg%02d", slot0._previews[slot2])))
	recthelper.setAnchorX(slot1.transform.parent, slot3)
end

function slot0.onDestroyView(slot0)
	slot0:_clearPage()
	slot0._simageFullBG1:UnLoadImage()
	slot0._simageFullBG2:UnLoadImage()
end

return slot0
