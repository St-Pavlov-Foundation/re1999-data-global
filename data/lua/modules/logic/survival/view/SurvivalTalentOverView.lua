module("modules.logic.survival.view.SurvivalTalentOverView", package.seeall)

local var_0_0 = class("SurvivalTalentOverView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#btn_Close")
	arg_1_0._txtlv = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Left/Lv/#txt_Lv")
	arg_1_0._imagetalentskill = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/Left/image_Card/image_CardIcon")
	arg_1_0._btnRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/Left/Lv/#btn_Right")
	arg_1_0._btnLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/Left/Lv/#btn_Left")
	arg_1_0._txtName = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Left/#txt_Skill")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/Layout/#go_Locked")
	arg_1_0._txtLock = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Left/Layout/#go_Locked/#txt_Locked")
	arg_1_0._txtDesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Left/Layout/#scroll_Descr/viewport/#txt_Descr")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "Panel/Right/#scroll_Descr/viewport/Content/#txt_Descr")
	arg_1_0._goscroll = gohelper.findChild(arg_1_0.viewGO, "Panel/Right/#scroll_Descr")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "Panel/Right/#go_empty")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.onClickModalMask, arg_2_0)
	arg_2_0._btnRight:AddClickListener(arg_2_0.onClickArrow, arg_2_0, 1)
	arg_2_0._btnLeft:AddClickListener(arg_2_0.onClickArrow, arg_2_0, -1)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnRight:RemoveClickListener()
	arg_3_0._btnLeft:RemoveClickListener()
end

function var_0_0.onClickModalMask(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onOpen(arg_5_0)
	local var_5_0 = SurvivalModel.instance:getOutSideInfo()

	if not var_5_0 then
		return
	end

	local var_5_1
	local var_5_2

	if arg_5_0.viewParam and arg_5_0.viewParam.talentCo then
		var_5_1 = arg_5_0.viewParam.talentCo.id
	else
		local var_5_3 = SurvivalShelterModel.instance:getWeekInfo()

		if not var_5_3 then
			return
		end

		var_5_1 = var_5_3.talentBox.groupId
		var_5_2 = {}

		for iter_5_0, iter_5_1 in ipairs(var_5_3.talentBox.talents) do
			var_5_2[iter_5_1.talentId] = true
		end
	end

	local var_5_4 = var_5_0.talentBox:getTalentGroup(var_5_1)
	local var_5_5 = lua_survival_talent_group.configDict[var_5_1]

	arg_5_0._txtName.text = var_5_5.name

	arg_5_0._imagetalentskill:LoadImage(ResUrl.getSurvivalTalentIcon(var_5_5.folder .. "/icon_1"))

	var_5_2 = var_5_2 or var_5_4.talents

	local var_5_6 = var_5_4:getTalentCos()
	local var_5_7 = 0
	local var_5_8 = {}

	for iter_5_2, iter_5_3 in ipairs(var_5_6) do
		if var_5_2[iter_5_3.id] then
			var_5_7 = var_5_7 + 1

			table.insert(var_5_8, {
				active = var_5_2[iter_5_3.id],
				co = iter_5_3
			})
		end
	end

	arg_5_0._equipLen = var_5_7

	gohelper.CreateObjList(arg_5_0, arg_5_0._createItem, var_5_8, nil, arg_5_0._goitem)
	gohelper.setActive(arg_5_0._goscroll, var_5_7 > 0)
	gohelper.setActive(arg_5_0._goempty, var_5_7 == 0)

	arg_5_0._collectCos = SurvivalConfig.instance.talentCollectCos[var_5_1]

	if not arg_5_0._collectCos then
		logError("没有天赋分支穿戴数量配置" .. tostring(var_5_1))

		return
	end

	local var_5_9 = 1

	for iter_5_4, iter_5_5 in ipairs(arg_5_0._collectCos) do
		if var_5_7 >= iter_5_5.num then
			var_5_9 = iter_5_4
		end
	end

	arg_5_0:onShowCollect(var_5_9)
end

function var_0_0.onClickArrow(arg_6_0, arg_6_1)
	arg_6_0._curIndex = Mathf.Clamp(arg_6_0._curIndex + arg_6_1, 1, #arg_6_0._collectCos)

	arg_6_0:onShowCollect(arg_6_0._curIndex)
end

function var_0_0.onShowCollect(arg_7_0, arg_7_1)
	arg_7_0._curIndex = arg_7_1
	arg_7_0._txtlv.text = "Lv." .. arg_7_1

	local var_7_0 = arg_7_0._collectCos[arg_7_1]

	if not var_7_0 then
		return
	end

	local var_7_1 = var_7_0.num > arg_7_0._equipLen

	gohelper.setActive(arg_7_0._btnLeft, arg_7_1 ~= 1)
	gohelper.setActive(arg_7_0._btnRight, arg_7_1 ~= #arg_7_0._collectCos)
	gohelper.setActive(arg_7_0._golock, var_7_1)

	arg_7_0._txtLock.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_talentview_lock"), var_7_0.num)
	arg_7_0._txtDesc.text = var_7_0.desc

	ZProj.UGUIHelper.SetColorAlpha(arg_7_0._txtDesc, var_7_1 and 0.5 or 1)
end

function var_0_0._createItem(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = gohelper.findChildTextMesh(arg_8_1, "")
	local var_8_1 = gohelper.findChildTextMesh(arg_8_1, "#txt_Skill")
	local var_8_2 = gohelper.findChildImage(arg_8_1, "#txt_Skill/image_SkillIcon")

	var_8_0.text = arg_8_2.co.desc1
	var_8_1.text = arg_8_2.co.name

	ZProj.UGUIHelper.SetColorAlpha(var_8_0, arg_8_2.active and 1 or 0.5)
	ZProj.UGUIHelper.SetColorAlpha(var_8_1, arg_8_2.active and 1 or 0.5)
	ZProj.UGUIHelper.SetColorAlpha(var_8_2, arg_8_2.active and 1 or 0.5)
end

return var_0_0
