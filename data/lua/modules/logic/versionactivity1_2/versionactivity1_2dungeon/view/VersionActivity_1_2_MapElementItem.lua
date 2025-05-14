module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_MapElementItem", package.seeall)

local var_0_0 = class("VersionActivity_1_2_MapElementItem", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._icon1 = gohelper.findChild(arg_1_0.viewGO, "ani/icon1/anim")
	arg_1_0._icon2 = gohelper.findChild(arg_1_0.viewGO, "ani/icon2/anim")
	arg_1_0._icon3 = gohelper.findChild(arg_1_0.viewGO, "ani/icon3/anim")

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

function var_0_0._onClick(arg_4_0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, arg_4_0._elementId)
end

function var_0_0.onRefreshViewParam(arg_5_0, arg_5_1)
	arg_5_0._elementId = arg_5_1
	arg_5_0._elementConfig = lua_chapter_map_element.configDict[arg_5_1]

	local var_5_0 = tonumber(arg_5_0._elementConfig.param)

	arg_5_0._episodeConfig = VersionActivity1_2DungeonModel.instance:getDailyEpisodeConfigByElementId(arg_5_0._elementId) or DungeonConfig.instance:getEpisodeCO(var_5_0)
end

function var_0_0.onOpen(arg_6_0)
	gohelper.setActive(arg_6_0._icon2, true)

	gohelper.findChild(arg_6_0._icon2, "num"):GetComponent(typeof(TMPro.TextMeshPro)).text = ""
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.onDestroyView(arg_8_0)
	return
end

return var_0_0
