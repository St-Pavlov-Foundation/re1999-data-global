module("modules.logic.summonsimulationpick.view.SummonSimulationPickListItem", package.seeall)

local var_0_0 = class("SummonSimulationPickListItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._simageHeroIcon = gohelper.findChildSingleImage(arg_1_0.go, "heroicon/#simage_icon")
	arg_1_0._imagecareer = gohelper.findChildImage(arg_1_0.go, "#image_career")
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0.go, "#image_rare")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.go, "#txt_name")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.go, "#txt_nameen")
	arg_1_0._btnclick = gohelper.findChildButton(arg_1_0.go, "")
	arg_1_0._btnLongPress = SLFramework.UGUI.UILongPressListener.Get(arg_1_0.go)

	arg_1_0._btnLongPress:SetLongPressTime({
		0.5,
		99999
	})
	arg_1_0._btnLongPress:AddLongPressListener(arg_1_0._onLongClickItem, arg_1_0)
	arg_1_0._btnclick:AddClickListener(arg_1_0._onbtnclick, arg_1_0)

	arg_1_0._gonew = gohelper.findChild(arg_1_0.go, "#go_new")
end

function var_0_0._onLongClickItem(arg_2_0)
	if not arg_2_0._heroId then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_action_explore)
	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		showHome = false,
		heroId = arg_2_0._heroId
	})
end

function var_0_0._onbtnclick(arg_3_0)
	if not arg_3_0._selectType then
		return
	end

	SummonSimulationPickController.instance:dispatchEvent(SummonSimulationEvent.onSelectItem, arg_3_0._selectType)
end

function var_0_0.removeEvent(arg_4_0)
	arg_4_0._btnclick:RemoveClickListener()
	arg_4_0._btnLongPress:RemoveLongPressListener()
end

function var_0_0.removeEventListeners(arg_5_0)
	arg_5_0._btnLongPress:RemoveLongPressListener()
end

function var_0_0.setData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._heroId = arg_6_1
	arg_6_0._selectType = arg_6_2

	arg_6_0:_refreshUI()
end

function var_0_0._refreshUI(arg_7_0)
	local var_7_0 = arg_7_0._heroId
	local var_7_1 = HeroConfig.instance:getHeroCO(var_7_0)
	local var_7_2 = var_7_1.skinId
	local var_7_3 = SkinConfig.instance:getSkinCo(var_7_2)

	arg_7_0._simageHeroIcon:LoadImage(ResUrl.getHeadIconMiddle(tostring(var_7_3.largeIcon)))

	arg_7_0._txtname.text = var_7_1.name
	arg_7_0._txtnameen.text = var_7_1.nameEng

	UISpriteSetMgr.instance:setCommonSprite(arg_7_0._imagecareer, "lssx_" .. tostring(var_7_1.career))
	UISpriteSetMgr.instance:setCommonSprite(arg_7_0._imagerare, "bg_pz00" .. tostring(CharacterEnum.Color[var_7_1.rare]))

	if not arg_7_0.newDot then
		arg_7_0.newDot = MonoHelper.addNoUpdateLuaComOnceToGo(arg_7_0._gonew, CommonRedDotIconNoEvent)

		arg_7_0.newDot:setShowType(RedDotEnum.Style.Green)
		arg_7_0.newDot:setCheckShowRedDotFunc(arg_7_0.refreshDot, arg_7_0)
	else
		arg_7_0.newDot:refreshRedDot()
	end

	gohelper.setActive(arg_7_0._gonew, true)
end

function var_0_0.refreshDot(arg_8_0, arg_8_1)
	return not HeroModel.instance:getByHeroId(arg_8_0._heroId)
end

function var_0_0.onDestroy(arg_9_0)
	arg_9_0._btnLongPress:RemoveLongPressListener()
	arg_9_0._btnclick:RemoveClickListener()
end

return var_0_0
