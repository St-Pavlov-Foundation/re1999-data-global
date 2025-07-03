module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonDescComp", package.seeall)

local var_0_0 = class("Act183DungeonDescComp", Act183DungeonBaseComp)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._gonormal = gohelper.findChild(arg_1_0.go, "#go_normal")
	arg_1_0._gohard = gohelper.findChild(arg_1_0.go, "#go_hard")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.go, "title/#txt_title")
	arg_1_0._godone = gohelper.findChild(arg_1_0.go, "title/#go_done")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.go, "#scroll_detail/Viewport/Content/top/#txt_desc")
	arg_1_0._btninfo = gohelper.findChildButtonWithAudio(arg_1_0.go, "title/#btn_Info")
	arg_1_0._gotop = gohelper.findChild(arg_1_0.go, "#scroll_detail/Viewport/Content/top")
	arg_1_0._topTran = arg_1_0._gotop.transform
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btninfo:AddClickListener(arg_2_0._btninfoOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btninfo:RemoveClickListener()
end

function var_0_0.checkIsVisible(arg_4_0)
	return true
end

function var_0_0.show(arg_5_0)
	var_0_0.super.show(arg_5_0)

	arg_5_0._txttitle.text = arg_5_0._episodeCo.title
	arg_5_0._txtdesc.text = arg_5_0._episodeCo.desc

	gohelper.setActive(arg_5_0._gonormal, arg_5_0._groupType ~= Act183Enum.GroupType.HardMain)
	gohelper.setActive(arg_5_0._gohard, arg_5_0._groupType == Act183Enum.GroupType.HardMain)
	gohelper.setActive(arg_5_0._godone, arg_5_0._status == Act183Enum.EpisodeStatus.Finished)
end

function var_0_0._btninfoOnClick(arg_6_0)
	local var_6_0 = DungeonConfig.instance:getEpisodeCO(arg_6_0._episodeId)

	if var_6_0 then
		EnemyInfoController.instance:openEnemyInfoViewByBattleId(var_6_0.battleId)
	end
end

function var_0_0.getHeight(arg_7_0)
	ZProj.UGUIHelper.RebuildLayout(arg_7_0._topTran)

	return recthelper.getHeight(arg_7_0._topTran)
end

function var_0_0.onDestroy(arg_8_0)
	var_0_0.super.onDestroy(arg_8_0)
end

return var_0_0
