module("modules.logic.toughbattle.view.ToughBattleSkillView", package.seeall)

local var_0_0 = class("ToughBattleSkillView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simgrole = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/view/role/#simage_role")
	arg_1_0._txttitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/view/title/titletxt")
	arg_1_0._txtskilldes = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/view/#txt_desc")
	arg_1_0._txtnormaldes = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/view/#txt_desc/#txt_desc2")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/view/#btn_closebtn")
	arg_1_0._goBuffContainer = gohelper.findChild(arg_1_0.viewGO, "root/#go_buffContainer")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._goBuffContainer, false)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:refreshSkillInfo(arg_5_0.viewParam.showCo)

	if arg_5_0.viewParam.isShowList then
		arg_5_0:createAndSelect()
	end
end

function var_0_0.createAndSelect(arg_6_0)
	local var_6_0 = arg_6_0:getResInst(arg_6_0.viewContainer._viewSetting.otherRes.rolelist, arg_6_0.viewGO, "rolelist")
	local var_6_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_0, ToughBattleRoleListComp, arg_6_0.viewParam)

	var_6_1:setClickCallBack(arg_6_0.onRoleSelect, arg_6_0)

	arg_6_0._roleList = var_6_1

	var_6_1:setSelect(arg_6_0.viewParam.showCo)
end

function var_0_0.onRoleSelect(arg_7_0, arg_7_1)
	arg_7_0:refreshSkillInfo(arg_7_1)
	arg_7_0._roleList:setSelect(arg_7_1)
end

function var_0_0.refreshSkillInfo(arg_8_0, arg_8_1)
	arg_8_0._simgrole:LoadImage("singlebg/toughbattle_singlebg/role/rolehalfpic" .. arg_8_1.sort .. ".png")

	local var_8_0 = lua_siege_battle_hero.configDict[arg_8_1.heroId]

	if not var_8_0 then
		logError("no hero co" .. arg_8_1.heroId)
	else
		arg_8_0._txttitle.text = var_8_0.name
		arg_8_0._txtskilldes.text = var_8_0.desc
	end

	arg_8_0._txtnormaldes.text = arg_8_1.instructionDesc
end

function var_0_0.onClickModalMask(arg_9_0)
	arg_9_0:closeThis()
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simgrole:UnLoadImage()
end

return var_0_0
