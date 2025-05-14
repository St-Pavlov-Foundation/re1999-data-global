module("modules.logic.herogroup.view.HeroGroupRecommendCharacterItem", package.seeall)

local var_0_0 = class("HeroGroupRecommendCharacterItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._gounselectedbg = gohelper.findChild(arg_1_1, "#go_info/#go_unselectedbg")
	arg_1_0._gobeselectedbg = gohelper.findChild(arg_1_1, "#go_info/#go_beselectedbg")
	arg_1_0._txtcharactername = gohelper.findChildText(arg_1_1, "#go_info/canvasgroup/#txt_charactername")
	arg_1_0._txtrate = gohelper.findChildText(arg_1_1, "#go_info/canvasgroup/#txt_rate")
	arg_1_0._simagecharacter = gohelper.findChildSingleImage(arg_1_1, "#go_info/canvasgroup/#simage_character")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_1, "#go_info/#btn_click")
	arg_1_0._goinfo = gohelper.findChild(arg_1_1, "#go_info")
	arg_1_0._gonull = gohelper.findChild(arg_1_1, "#go_null")
	arg_1_0._txtrank = gohelper.findChildText(arg_1_1, "#txt_rank")
	arg_1_0._gomask = gohelper.findChild(arg_1_1, "#go_info/#go_mask")
	arg_1_0._anim = arg_1_1:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if arg_4_0._mo.isEmpty then
		return
	end

	if not arg_4_0._isSelect then
		arg_4_0._view:selectCell(arg_4_0._index, true)
	end
end

function var_0_0.onSelect(arg_5_0, arg_5_1)
	arg_5_0._isSelect = arg_5_1

	if arg_5_0._isSelect and not HeroGroupRecommendGroupListModel.instance:isShowSampleMo(arg_5_0._mo) then
		HeroGroupRecommendGroupListModel.instance:setGroupList(arg_5_0._mo)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickRecommendCharacter)
	end

	gohelper.setActive(arg_5_0._gounselectedbg, not arg_5_0._isSelect)
	gohelper.setActive(arg_5_0._gobeselectedbg, arg_5_0._isSelect)

	local var_5_0 = arg_5_0:_getCurStateType()

	arg_5_0:_setInfoShowByStateType(var_5_0)
end

var_0_0.StateType = {
	UnSelectedUnOwner = 3,
	SelectedAndOwner = 2,
	SelectedUnOwner = 1,
	UnSelectedAndOwner = 4
}

function var_0_0._getCurStateType(arg_6_0)
	local var_6_0

	if not HeroModel.instance:getByHeroId(arg_6_0._mo.heroId) then
		var_6_0 = arg_6_0._isSelect and var_0_0.StateType.SelectedUnOwner or var_0_0.StateType.UnSelectedUnOwner
	else
		var_6_0 = arg_6_0._isSelect and var_0_0.StateType.SelectedAndOwner or var_0_0.StateType.UnSelectedAndOwner
	end

	return var_6_0
end

function var_0_0._setInfoShowByStateType(arg_7_0, arg_7_1)
	if arg_7_1 == var_0_0.StateType.SelectedUnOwner or arg_7_1 == var_0_0.StateType.SelectedAndOwner then
		SLFramework.UGUI.GuiHelper.SetColor(arg_7_0._txtcharactername, "#433A3A")
		ZProj.UGUIHelper.SetColorAlpha(arg_7_0._txtcharactername, 1)
		SLFramework.UGUI.GuiHelper.SetColor(arg_7_0._txtrate, "#433A3A")
		ZProj.UGUIHelper.SetColorAlpha(arg_7_0._txtrate, 1)
		SLFramework.UGUI.GuiHelper.SetColor(arg_7_0._txtrank, "#433A3A")
		ZProj.UGUIHelper.SetColorAlpha(arg_7_0._txtrank, 0.4)

		arg_7_0._txtcharactername.fontSize = 48
	elseif arg_7_1 == var_0_0.StateType.UnSelectedUnOwner then
		SLFramework.UGUI.GuiHelper.SetColor(arg_7_0._txtcharactername, "#979797")
		ZProj.UGUIHelper.SetColorAlpha(arg_7_0._txtcharactername, 0.3)
		SLFramework.UGUI.GuiHelper.SetColor(arg_7_0._txtrate, "#979797")
		ZProj.UGUIHelper.SetColorAlpha(arg_7_0._txtrate, 0.3)
		SLFramework.UGUI.GuiHelper.SetColor(arg_7_0._txtrank, "#73726F")
		ZProj.UGUIHelper.SetColorAlpha(arg_7_0._txtrank, 0.15)

		arg_7_0._txtcharactername.fontSize = 42
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_7_0._txtcharactername, "#979797")
		ZProj.UGUIHelper.SetColorAlpha(arg_7_0._txtcharactername, 1)
		SLFramework.UGUI.GuiHelper.SetColor(arg_7_0._txtrate, "#979797")
		ZProj.UGUIHelper.SetColorAlpha(arg_7_0._txtrate, 1)
		SLFramework.UGUI.GuiHelper.SetColor(arg_7_0._txtrank, "#73726F")
		ZProj.UGUIHelper.SetColorAlpha(arg_7_0._txtrank, 0.15)

		arg_7_0._txtcharactername.fontSize = 42
	end

	gohelper.setActive(arg_7_0._gomask, arg_7_1 == var_0_0.StateType.UnSelectedUnOwner or arg_7_1 == var_0_0.StateType.UnSelectedAndOwner)
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1

	gohelper.setActive(arg_8_0._gonull, arg_8_0._mo.isEmpty)
	gohelper.setActive(arg_8_0._goinfo, not arg_8_0._mo.isEmpty)

	arg_8_0._txtrank.text = GameUtil.fillZeroInLeft(arg_8_0._index, 2)

	if arg_8_0._mo.isEmpty then
		gohelper.setActive(arg_8_0._gounselectedbg, true)
		gohelper.setActive(arg_8_0._gobeselectedbg, false)

		return
	end

	local var_8_0 = HeroConfig.instance:getHeroCO(arg_8_0._mo.heroId)

	arg_8_0._txtcharactername.text = var_8_0.name
	arg_8_0._txtrate.text = string.format("%s%%", math.floor(arg_8_0._mo.rate * 10000) / 100)

	local var_8_1 = SkinConfig.instance:getSkinCo(var_8_0.skinId)

	arg_8_0._simagecharacter:LoadImage(ResUrl.getHeadIconSmall(var_8_1.headIcon))
end

function var_0_0.getAnimator(arg_9_0)
	return arg_9_0._anim
end

function var_0_0.onDestroy(arg_10_0)
	arg_10_0._simagecharacter:UnLoadImage()
end

return var_0_0
