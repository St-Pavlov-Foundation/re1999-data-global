module("modules.logic.survival.view.map.comp.SurvivalEventViewItem", package.seeall)

local var_0_0 = class("SurvivalEventViewItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._btnClick = gohelper.findChildButtonWithAudio(arg_1_1, "")
	arg_1_0._goselect = gohelper.findChild(arg_1_1, "Rotate/#go_Selected")
	arg_1_0._gounselect = gohelper.findChild(arg_1_1, "Rotate/#go_Mask")
	arg_1_0._imagehead = gohelper.findChildSingleImage(arg_1_1, "Rotate/#image_head")
	arg_1_0._imagecolor = gohelper.findChildImage(arg_1_1, "Rotate/#image_color")
	arg_1_0._imageIcon = gohelper.findChildImage(arg_1_1, "Rotate/#simage_Icon")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnClick:AddClickListener(arg_2_0._onClick, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnEventViewSelectChange, arg_2_0.onSelectChange, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnClick:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnEventViewSelectChange, arg_3_0.onSelectChange, arg_3_0)
end

local var_0_1 = {
	[SurvivalEnum.UnitType.Search] = "survivalevent_itemiconbg3",
	[SurvivalEnum.UnitType.Task] = "survivalevent_itemiconbg3",
	[SurvivalEnum.UnitType.NPC] = "survivalevent_itemiconbg3",
	[SurvivalEnum.UnitType.Treasure] = "survivalevent_itemiconbg3",
	[SurvivalEnum.UnitType.Battle] = "survivalevent_itemiconbg1",
	[SurvivalEnum.UnitType.Exit] = "survivalevent_itemiconbg2",
	[SurvivalEnum.UnitType.Door] = "survivalevent_itemiconbg2"
}
local var_0_2 = {
	[SurvivalEnum.UnitType.Task] = "survival_map_icon_1",
	[SurvivalEnum.UnitType.NPC] = "survival_map_icon_2",
	[SurvivalEnum.UnitType.Treasure] = "survival_map_icon_5",
	[SurvivalEnum.UnitType.Exit] = "survival_map_icon_8",
	[SurvivalEnum.UnitType.Door] = "survival_map_icon_9"
}

function var_0_0.initData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.data = arg_4_1
	arg_4_0.index = arg_4_2

	arg_4_0:onSelectChange(1)

	local var_4_0 = arg_4_1.unitType

	if var_4_0 == SurvivalEnum.UnitType.NPC then
		gohelper.setActive(arg_4_0._imagehead, true)
		gohelper.setActive(arg_4_0._imagecolor, false)
		gohelper.setActive(arg_4_0._imageIcon, false)

		local var_4_1 = SurvivalConfig.instance.npcIdToItemCo[arg_4_1.cfgId]

		if var_4_1 then
			arg_4_0._imagehead:LoadImage(ResUrl.getSurvivalNpcIcon(var_4_1.icon))
		end
	else
		gohelper.setActive(arg_4_0._imagehead, false)
		gohelper.setActive(arg_4_0._imagecolor, true)
		gohelper.setActive(arg_4_0._imageIcon, true)
		UISpriteSetMgr.instance:setSurvivalSprite(arg_4_0._imagecolor, var_0_1[var_4_0])

		if var_4_0 == SurvivalEnum.UnitType.Search then
			if arg_4_1.extraParam == "true" then
				UISpriteSetMgr.instance:setSurvivalSprite(arg_4_0._imageIcon, "survival_map_icon_4")
			else
				UISpriteSetMgr.instance:setSurvivalSprite(arg_4_0._imageIcon, "survival_map_icon_3")
			end
		elseif var_4_0 == SurvivalEnum.UnitType.Battle then
			if arg_4_1.co.type == 41 or arg_4_1.co.type == 43 then
				UISpriteSetMgr.instance:setSurvivalSprite(arg_4_0._imageIcon, "survival_map_icon_6")
			else
				UISpriteSetMgr.instance:setSurvivalSprite(arg_4_0._imageIcon, "survival_map_icon_7")
			end
		else
			UISpriteSetMgr.instance:setSurvivalSprite(arg_4_0._imageIcon, var_0_2[var_4_0])
		end
	end
end

function var_0_0._onClick(arg_5_0)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnEventViewSelectChange, arg_5_0.index)
end

function var_0_0.onSelectChange(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0._goselect, arg_6_1 == arg_6_0.index)
	gohelper.setActive(arg_6_0._gounselect, arg_6_1 ~= arg_6_0.index)
end

return var_0_0
