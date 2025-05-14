module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchRightHeroItem", package.seeall)

local var_0_0 = class("RoleStoryDispatchRightHeroItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goAdd = gohelper.findChild(arg_1_0.viewGO, "add")
	arg_1_0.goHero = gohelper.findChild(arg_1_0.viewGO, "#go_hero")
	arg_1_0.simageHeroIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_hero/#simage_heroicon")
	arg_1_0.imageCareer = gohelper.findChildImage(arg_1_0.viewGO, "#go_hero/#image_career")
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
	if arg_4_0.index > arg_4_0.maxCount then
		gohelper.setActive(arg_4_0.viewGO, false)

		return
	end

	gohelper.setActive(arg_4_0.viewGO, true)
	gohelper.setActive(arg_4_0.goAdd, not arg_4_0.data)

	if not arg_4_0.data then
		arg_4_0:clear()
		gohelper.setActive(arg_4_0.goHero, false)

		return
	end

	gohelper.setActive(arg_4_0.goHero, true)

	local var_4_0 = arg_4_0.data.config

	arg_4_0.simageHeroIcon:LoadImage(ResUrl.getRoomHeadIcon(var_4_0.id .. "01"))
	UISpriteSetMgr.instance:setCommonSprite(arg_4_0.imageCareer, "lssx_" .. var_4_0.career)
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.data = arg_5_1
	arg_5_0.index = arg_5_2
	arg_5_0.maxCount = arg_5_3

	arg_5_0:refreshItem()
end

function var_0_0.onClickBtnClick(arg_6_0)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ClickRightHero, arg_6_0.data)
end

function var_0_0._editableInitView(arg_7_0)
	return
end

function var_0_0.clear(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0:clear()

	if arg_9_0.simageHeroIcon then
		arg_9_0.simageHeroIcon:UnLoadImage()

		arg_9_0.simageHeroIcon = nil
	end
end

return var_0_0
