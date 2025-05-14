module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchLeftHeroItem", package.seeall)

local var_0_0 = class("RoleStoryDispatchLeftHeroItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goHero = gohelper.findChild(arg_1_0.viewGO, "#go_hero")
	arg_1_0.simageHeroIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_icon")
	arg_1_0.imageCareer = gohelper.findChildImage(arg_1_0.viewGO, "#image_career")
	arg_1_0.goDispatched = gohelper.findChild(arg_1_0.viewGO, "#go_dispatched")
	arg_1_0.goSelected = gohelper.findChild(arg_1_0.viewGO, "#go_selected")
	arg_1_0.txtIndex = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_selected/#txt_index")
	arg_1_0.goUp = gohelper.findChild(arg_1_0.viewGO, "upicon")
	arg_1_0.btnClick = gohelper.findButtonWithAudio(arg_1_0.viewGO)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClick, arg_2_0.onClickBtnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.refreshItem(arg_4_0)
	arg_4_0.config = arg_4_0.mo.config

	arg_4_0.simageHeroIcon:LoadImage(ResUrl.getRoomHeadIcon(arg_4_0.config.id .. "01"))
	UISpriteSetMgr.instance:setCommonSprite(arg_4_0.imageCareer, "lssx_" .. arg_4_0.config.career)

	local var_4_0 = arg_4_0.mo:isDispatched()
	local var_4_1 = RoleStoryDispatchHeroListModel.instance:getSelectedIndex(arg_4_0.mo.heroId)
	local var_4_2 = var_4_1 ~= nil

	gohelper.setActive(arg_4_0.goDispatched, var_4_0)
	gohelper.setActive(arg_4_0.goSelected, var_4_2)

	if var_4_2 then
		arg_4_0.txtIndex.text = var_4_1
	end

	gohelper.setActive(arg_4_0.goUp, arg_4_0.mo:isEffectHero())
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0.mo = arg_5_1

	arg_5_0:refreshItem()
end

function var_0_0.onClickBtnClick(arg_6_0)
	RoleStoryDispatchHeroListModel.instance:clickHeroMo(arg_6_0.mo)
end

function var_0_0._editableInitView(arg_7_0)
	return
end

function var_0_0.onDestroyView(arg_8_0)
	if arg_8_0.simageHeroIcon then
		arg_8_0.simageHeroIcon:UnLoadImage()

		arg_8_0.simageHeroIcon = nil
	end
end

return var_0_0
