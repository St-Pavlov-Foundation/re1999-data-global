module("modules.logic.character.view.CharacterDataView", package.seeall)

slot0 = class("CharacterDataView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollchildview = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_childview")
	slot0._content1 = gohelper.findChild(slot0.viewGO, "content1")
	slot0._content2 = gohelper.findChild(slot0.viewGO, "content/content2")
	slot0._content3 = gohelper.findChild(slot0.viewGO, "content/content3")
	slot0._page1go = gohelper.findChild(slot0.viewGO, "catagory/page1")
	slot0._page2go = gohelper.findChild(slot0.viewGO, "catagory/page2")
	slot0._page3go = gohelper.findChild(slot0.viewGO, "catagory/page3")
	slot0._page4go = gohelper.findChild(slot0.viewGO, "catagory/page4")
	slot0._goculturereddot = gohelper.findChild(slot0.viewGO, "catagory/page4/#go_reddot")
	slot0._goitemreddot = gohelper.findChild(slot0.viewGO, "catagory/page3/#go_reddot")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._page1click = SLFramework.UGUI.UIClickListener.Get(slot0._page1go)
	slot0._page2click = SLFramework.UGUI.UIClickListener.Get(slot0._page2go)
	slot0._page3click = SLFramework.UGUI.UIClickListener.Get(slot0._page3go)
	slot0._page4click = SLFramework.UGUI.UIClickListener.Get(slot0._page4go)

	slot0._page1click:AddClickListener(slot0._page1OnClick, slot0)
	slot0._page2click:AddClickListener(slot0._page2OnClick, slot0)
	slot0._page3click:AddClickListener(slot0._page3OnClick, slot0)
	slot0._page4click:AddClickListener(slot0._page4OnClick, slot0)

	slot0._pagenow = 1

	slot0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, slot0.refreshRedDot, slot0)
end

function slot0._page1OnClick(slot0)
	slot0:_selectPage(1)
end

function slot0._page2OnClick(slot0)
	slot0:_selectPage(2)
end

function slot0._page3OnClick(slot0)
	slot0:_selectPage(3)
end

function slot0._page4OnClick(slot0)
	slot0:_selectPage(4)
end

function slot0._selectPage(slot0, slot1)
	if slot1 == slot0._pagenow then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_role_introduce_switch)
	slot0:_setNowPage(slot1)

	slot2 = nil

	if slot1 == 2 then
		slot2 = module_views_preloader.CharacterDataVoiceView
	elseif slot1 == 3 then
		slot2 = module_views_preloader.CharacterDataItemView
	elseif slot1 == 4 then
		slot2 = module_views_preloader.CharacterDataCultureView
	end

	if slot2 then
		slot2(function ()
			uv0.viewContainer:switchTab(uv1)
		end)
	else
		slot0.viewContainer:switchTab(slot1)
	end
end

function slot0._setNowPage(slot0, slot1)
	for slot5 = 1, 4 do
		gohelper.setActive(gohelper.findChild(slot0.viewGO, "catagory/page" .. slot5 .. "/#go_selected"), slot5 == slot1)
		gohelper.setActive(gohelper.findChild(slot0.viewGO, "catagory/page" .. slot5 .. "/#go_unselected"), slot5 ~= slot1)
	end

	slot0._pagenow = slot1
end

function slot0.onUpdateParam(slot0)
	slot0:onOpen()
end

function slot0.onOpenFinish(slot0)
	gohelper.addChild(gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUP_SECOND"), slot0.viewGO)

	slot0._heroId = CharacterDataModel.instance:getCurHeroId()
	slot2 = slot0._heroId and HeroModel.instance:getByHeroId(slot0._heroId)

	if not (slot2 and SkinConfig.instance:getSkinCo(slot2.skin)) then
		return
	end

	if slot3.id and lua_skin_ui_bloom.configDict[slot4] and slot5[CharacterVoiceEnum.UIBloomView.CharacterDataView] == 1 then
		PostProcessingMgr.instance:setUIBloom(true)
	end
end

function slot0.onOpen(slot0)
	UnityEngine.Shader.EnableKeyword("_TRANSVERSEALPHA_ON")

	if type(slot0.viewParam) == "table" then
		slot0.heroId = slot0.viewParam.heroId
		slot0.fromHandbookView = slot0.viewParam.fromHandbookView
	else
		slot0.heroId = slot0.viewParam
		slot0.fromHandbookView = false
	end

	CharacterDataModel.instance:setCurHeroId(slot0.heroId)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.SelectPage, slot0._onSelectPage, slot0)
	slot0:refreshRedDot()
end

function slot0._onSelectPage(slot0, slot1)
	slot0:_selectPage(slot1)
end

function slot0.refreshRedDot(slot0)
	gohelper.setActive(slot0._goculturereddot, CharacterModel.instance:hasCultureRewardGet(slot0.heroId))
	gohelper.setActive(slot0._goitemreddot, CharacterModel.instance:hasItemRewardGet(slot0.heroId))
end

function slot0.onClose(slot0)
	UnityEngine.Shader.DisableKeyword("_TRANSVERSEALPHA_ON")
	PostProcessingMgr.instance:setUIBloom(false)
	gohelper.addChild(gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUP_TOP"), slot0.viewGO)
end

function slot0.onDestroyView(slot0)
	slot0._page1click:RemoveClickListener()
	slot0._page2click:RemoveClickListener()
	slot0._page3click:RemoveClickListener()
	slot0._page4click:RemoveClickListener()
end

return slot0
