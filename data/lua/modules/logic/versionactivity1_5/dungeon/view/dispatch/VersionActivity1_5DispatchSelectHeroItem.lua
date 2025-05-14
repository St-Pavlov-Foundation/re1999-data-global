module("modules.logic.versionactivity1_5.dungeon.view.dispatch.VersionActivity1_5DispatchSelectHeroItem", package.seeall)

local var_0_0 = class("VersionActivity1_5DispatchSelectHeroItem", UserDataDispose)

function var_0_0.createItem(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.New()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:__onInit()

	arg_2_0.index = arg_2_2
	arg_2_0.go = arg_2_1
	arg_2_0.goHero = gohelper.findChild(arg_2_0.go, "#go_hero")
	arg_2_0.simageHeroIcon = gohelper.findChildSingleImage(arg_2_0.go, "#go_hero/#simage_heroicon")
	arg_2_0.imageCareer = gohelper.findChildImage(arg_2_0.go, "#go_hero/#image_career")
	arg_2_0.click = gohelper.getClick(arg_2_0.go)

	arg_2_0.click:AddClickListener(arg_2_0.onClickSelf, arg_2_0)
	gohelper.setActive(arg_2_0.goHero, false)
	arg_2_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.ChangeSelectedHero, arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.onClickSelf(arg_3_0)
	if not VersionActivity1_5HeroListModel.instance:canChangeHeroMo() then
		return
	end

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.ChangeDispatchHeroContainerEvent, true)

	if arg_3_0.mo == nil then
		return
	end

	VersionActivity1_5HeroListModel.instance:deselectMo(arg_3_0.mo)
end

function var_0_0.isSelected(arg_4_0)
	return arg_4_0.mo ~= nil
end

function var_0_0.refreshUI(arg_5_0)
	arg_5_0.mo = VersionActivity1_5HeroListModel.instance:getSelectedMoByIndex(arg_5_0.index)

	gohelper.setActive(arg_5_0.goHero, arg_5_0:isSelected())

	if arg_5_0:isSelected() then
		arg_5_0.heroCo = arg_5_0.mo.config

		arg_5_0.simageHeroIcon:LoadImage(ResUrl.getRoomHeadIcon(arg_5_0.heroCo.id .. "01"))
		UISpriteSetMgr.instance:setCommonSprite(arg_5_0.imageCareer, "lssx_" .. arg_5_0.heroCo.career)
	end
end

function var_0_0.destroy(arg_6_0)
	arg_6_0.simageHeroIcon:UnLoadImage()
	arg_6_0.click:RemoveClickListener()
	arg_6_0:__onDispose()
end

return var_0_0
