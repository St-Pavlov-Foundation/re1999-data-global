module("modules.logic.player.view.PlayerClothItem", package.seeall)

local var_0_0 = class("PlayerClothItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._bg = gohelper.findChildImage(arg_1_1, "bg")
	arg_1_0._imgBg = gohelper.findChildSingleImage(arg_1_1, "skillicon")
	arg_1_0._inUseGO = gohelper.findChild(arg_1_1, "inuse")
	arg_1_0._beSelectedGO = gohelper.findChild(arg_1_1, "beselected")
	arg_1_0._clickThis = gohelper.getClick(arg_1_1)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._clickThis:AddClickListener(arg_2_0._onClickThis, arg_2_0)
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnModifyHeroGroup, arg_2_0._onChangeClothId, arg_2_0)
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnSnapshotSaveSucc, arg_2_0._onChangeClothId, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._clickThis:RemoveClickListener()
	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnModifyHeroGroup, arg_3_0._onChangeClothId, arg_3_0)
	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnSnapshotSaveSucc, arg_3_0._onChangeClothId, arg_3_0)
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0.mo = arg_4_1

	local var_4_0 = lua_cloth.configDict[arg_4_1.clothId]

	arg_4_0._imgBg:LoadImage(ResUrl.getPlayerClothIcon(tostring(arg_4_1.clothId)))

	if arg_4_0._view:getFirstSelect() == arg_4_1 then
		arg_4_0:onSelect(true)
	end

	arg_4_0:_updateOnUse()
end

function var_0_0._updateOnUse(arg_5_0)
	local var_5_0 = PlayerClothListViewModel.instance:getGroupModel()
	local var_5_1 = var_5_0 and var_5_0:getCurGroupMO()
	local var_5_2 = (PlayerClothModel.instance:getSpEpisodeClothID() or var_5_1 and var_5_1.clothId) == arg_5_0.mo.clothId

	gohelper.setActive(arg_5_0._beSelectedGO, arg_5_0._isSelect)
	gohelper.setActive(arg_5_0._inUseGO, var_5_2)
end

function var_0_0.onSelect(arg_6_0, arg_6_1)
	arg_6_0._isSelect = arg_6_1

	arg_6_0:_updateOnUse()
end

function var_0_0._onChangeClothId(arg_7_0)
	arg_7_0:_updateOnUse()
end

function var_0_0._onClickThis(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if PlayerClothModel.instance:getSpEpisodeClothID() then
		return
	end

	if not arg_8_0._isSelect then
		PlayerController.instance:dispatchEvent(PlayerEvent.SelectCloth, arg_8_0.mo.clothId)
	end
end

return var_0_0
