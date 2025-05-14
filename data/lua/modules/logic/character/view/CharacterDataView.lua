module("modules.logic.character.view.CharacterDataView", package.seeall)

local var_0_0 = class("CharacterDataView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollchildview = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_childview")
	arg_1_0._content1 = gohelper.findChild(arg_1_0.viewGO, "content1")
	arg_1_0._content2 = gohelper.findChild(arg_1_0.viewGO, "content/content2")
	arg_1_0._content3 = gohelper.findChild(arg_1_0.viewGO, "content/content3")
	arg_1_0._page1go = gohelper.findChild(arg_1_0.viewGO, "catagory/page1")
	arg_1_0._page2go = gohelper.findChild(arg_1_0.viewGO, "catagory/page2")
	arg_1_0._page3go = gohelper.findChild(arg_1_0.viewGO, "catagory/page3")
	arg_1_0._page4go = gohelper.findChild(arg_1_0.viewGO, "catagory/page4")
	arg_1_0._goculturereddot = gohelper.findChild(arg_1_0.viewGO, "catagory/page4/#go_reddot")
	arg_1_0._goitemreddot = gohelper.findChild(arg_1_0.viewGO, "catagory/page3/#go_reddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._page1click = SLFramework.UGUI.UIClickListener.Get(arg_4_0._page1go)
	arg_4_0._page2click = SLFramework.UGUI.UIClickListener.Get(arg_4_0._page2go)
	arg_4_0._page3click = SLFramework.UGUI.UIClickListener.Get(arg_4_0._page3go)
	arg_4_0._page4click = SLFramework.UGUI.UIClickListener.Get(arg_4_0._page4go)

	arg_4_0._page1click:AddClickListener(arg_4_0._page1OnClick, arg_4_0)
	arg_4_0._page2click:AddClickListener(arg_4_0._page2OnClick, arg_4_0)
	arg_4_0._page3click:AddClickListener(arg_4_0._page3OnClick, arg_4_0)
	arg_4_0._page4click:AddClickListener(arg_4_0._page4OnClick, arg_4_0)

	arg_4_0._pagenow = 1

	arg_4_0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_4_0.refreshRedDot, arg_4_0)
end

function var_0_0._page1OnClick(arg_5_0)
	arg_5_0:_selectPage(1)
end

function var_0_0._page2OnClick(arg_6_0)
	arg_6_0:_selectPage(2)
end

function var_0_0._page3OnClick(arg_7_0)
	arg_7_0:_selectPage(3)
end

function var_0_0._page4OnClick(arg_8_0)
	arg_8_0:_selectPage(4)
end

function var_0_0._selectPage(arg_9_0, arg_9_1)
	if arg_9_1 == arg_9_0._pagenow then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_role_introduce_switch)
	arg_9_0:_setNowPage(arg_9_1)

	local var_9_0

	if arg_9_1 == 2 then
		var_9_0 = module_views_preloader.CharacterDataVoiceView
	elseif arg_9_1 == 3 then
		var_9_0 = module_views_preloader.CharacterDataItemView
	elseif arg_9_1 == 4 then
		var_9_0 = module_views_preloader.CharacterDataCultureView
	end

	if var_9_0 then
		var_9_0(function()
			arg_9_0.viewContainer:switchTab(arg_9_1)
		end)
	else
		arg_9_0.viewContainer:switchTab(arg_9_1)
	end
end

function var_0_0._setNowPage(arg_11_0, arg_11_1)
	for iter_11_0 = 1, 4 do
		local var_11_0 = gohelper.findChild(arg_11_0.viewGO, "catagory/page" .. iter_11_0 .. "/#go_selected")
		local var_11_1 = gohelper.findChild(arg_11_0.viewGO, "catagory/page" .. iter_11_0 .. "/#go_unselected")

		gohelper.setActive(var_11_0, iter_11_0 == arg_11_1)
		gohelper.setActive(var_11_1, iter_11_0 ~= arg_11_1)
	end

	arg_11_0._pagenow = arg_11_1
end

function var_0_0.onUpdateParam(arg_12_0)
	arg_12_0:onOpen()
end

function var_0_0.onOpenFinish(arg_13_0)
	local var_13_0 = gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUP_SECOND")

	gohelper.addChild(var_13_0, arg_13_0.viewGO)

	arg_13_0._heroId = CharacterDataModel.instance:getCurHeroId()

	local var_13_1 = arg_13_0._heroId and HeroModel.instance:getByHeroId(arg_13_0._heroId)
	local var_13_2 = var_13_1 and SkinConfig.instance:getSkinCo(var_13_1.skin)

	if not var_13_2 then
		return
	end

	local var_13_3 = var_13_2.id
	local var_13_4 = var_13_3 and lua_skin_ui_bloom.configDict[var_13_3]

	if var_13_4 and var_13_4[CharacterVoiceEnum.UIBloomView.CharacterDataView] == 1 then
		PostProcessingMgr.instance:setUIBloom(true)
	end
end

function var_0_0.onOpen(arg_14_0)
	UnityEngine.Shader.EnableKeyword("_TRANSVERSEALPHA_ON")

	if type(arg_14_0.viewParam) == "table" then
		arg_14_0.heroId = arg_14_0.viewParam.heroId
		arg_14_0.fromHandbookView = arg_14_0.viewParam.fromHandbookView
	else
		arg_14_0.heroId = arg_14_0.viewParam
		arg_14_0.fromHandbookView = false
	end

	CharacterDataModel.instance:setCurHeroId(arg_14_0.heroId)
	arg_14_0:addEventCb(CharacterController.instance, CharacterEvent.SelectPage, arg_14_0._onSelectPage, arg_14_0)
	arg_14_0:refreshRedDot()
end

function var_0_0._onSelectPage(arg_15_0, arg_15_1)
	arg_15_0:_selectPage(arg_15_1)
end

function var_0_0.refreshRedDot(arg_16_0)
	local var_16_0 = CharacterModel.instance:hasCultureRewardGet(arg_16_0.heroId)

	gohelper.setActive(arg_16_0._goculturereddot, var_16_0)

	local var_16_1 = CharacterModel.instance:hasItemRewardGet(arg_16_0.heroId)

	gohelper.setActive(arg_16_0._goitemreddot, var_16_1)
end

function var_0_0.onClose(arg_17_0)
	UnityEngine.Shader.DisableKeyword("_TRANSVERSEALPHA_ON")
	PostProcessingMgr.instance:setUIBloom(false)

	local var_17_0 = gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUP_TOP")

	gohelper.addChild(var_17_0, arg_17_0.viewGO)
end

function var_0_0.onDestroyView(arg_18_0)
	arg_18_0._page1click:RemoveClickListener()
	arg_18_0._page2click:RemoveClickListener()
	arg_18_0._page3click:RemoveClickListener()
	arg_18_0._page4click:RemoveClickListener()
end

return var_0_0
