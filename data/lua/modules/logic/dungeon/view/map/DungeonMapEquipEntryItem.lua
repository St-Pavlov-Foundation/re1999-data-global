module("modules.logic.dungeon.view.map.DungeonMapEquipEntryItem", package.seeall)

local var_0_0 = class("DungeonMapEquipEntryItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._index = arg_1_1[1]
	arg_1_0._chapterId = arg_1_1[2]
	arg_1_0._readyChapterId = nil
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.viewGO = arg_2_1
	arg_2_0._simageicon = gohelper.findChildSingleImage(arg_2_0.viewGO, "#simage_icon")
	arg_2_0._txtnum = gohelper.findChildText(arg_2_0.viewGO, "#txt_num")
	arg_2_0._imagefull = gohelper.findChildImage(arg_2_0.viewGO, "progress/#image_full")
	arg_2_0._txtprogressNum = gohelper.findChildText(arg_2_0.viewGO, "progress/#txt_progressNum")

	local var_2_0 = lua_equip_chapter.configDict[arg_2_0._chapterId]
	local var_2_1 = string.format("entry/bg_fuben_tesurukou_%s", var_2_0.group)

	arg_2_0._simageicon:LoadImage(ResUrl.getDungeonIcon(var_2_1))

	local var_2_2 = DungeonConfig.instance:getChapterEpisodeCOList(arg_2_0._chapterId)
	local var_2_3 = #var_2_2
	local var_2_4 = 0

	for iter_2_0, iter_2_1 in ipairs(var_2_2) do
		local var_2_5 = DungeonModel.instance:getEpisodeInfo(iter_2_1.id)

		if DungeonModel.instance:hasPassLevel(iter_2_1.id) and var_2_5.challengeCount == 1 then
			var_2_4 = var_2_4 + 1
		else
			arg_2_0._readyChapterId = iter_2_1.id

			break
		end
	end

	arg_2_0._txtprogressNum.text = string.format("%s/%s", var_2_4, var_2_3)
	arg_2_0._txtnum.text = "0" .. arg_2_0._index
	arg_2_0._imagefull.fillAmount = var_2_4 / var_2_3
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._click = gohelper.getClickWithAudio(arg_3_0.viewGO)

	arg_3_0._click:AddClickListener(arg_3_0._onClick, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._click:RemoveClickListener()
end

function var_0_0._onClick(arg_5_0)
	DungeonController.instance:openDungeonEquipEntryView(arg_5_0._chapterId)
end

function var_0_0.onStart(arg_6_0)
	return
end

function var_0_0.onDestroy(arg_7_0)
	return
end

return var_0_0
