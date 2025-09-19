module("modules.logic.survival.view.shelter.SurvivalReportView", package.seeall)

local var_0_0 = class("SurvivalReportView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageMask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Mask")
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/#simage_PanelBG")
	arg_1_0._simagePanelBG1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/#simage_PanelBG1")
	arg_1_0._simagePanelBG2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/#simage_PanelBG2")
	arg_1_0._scrollcontentlist = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_contentlist")
	arg_1_0._txtdec1 = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#txt_dec1")
	arg_1_0._goNpc = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Npc")
	arg_1_0._txtNpc = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Npc/#txt_Npc")
	arg_1_0._goNpcNew = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_NpcNew")
	arg_1_0._txtNpcNew = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_NpcNew/#txt_NpcNew")
	arg_1_0._goMonster = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Monster")
	arg_1_0._txtMonster = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Monster/#txt_Monster")
	arg_1_0._goBuilding = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Building")
	arg_1_0._txtBuilding = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Building/#txt_Building")
	arg_1_0._goTask = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Task")
	arg_1_0._txtTask = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Task/#txt_Task")
	arg_1_0._goTaskScore = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Task/#go_TaskScore")
	arg_1_0._txtnpcScore = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Task/#go_TaskScore/#txt_npcScore")
	arg_1_0._txtdec2 = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#txt_dec2")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onClickModalMask(arg_7_0)
	arg_7_0:_btncloseOnClick()
end

function var_0_0.onOpen(arg_8_0)
	local var_8_0 = SurvivalModel.instance:getDailyReport()

	arg_8_0._report = nil

	if not string.nilorempty(var_8_0) then
		arg_8_0._report = cjson.decode(var_8_0)
	end

	SurvivalModel.instance:setDailyReport()
	arg_8_0:_initView()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_general_2)
end

function var_0_0._initView(arg_9_0)
	arg_9_0:_initNpc()
	arg_9_0:_initMonster()
	gohelper.setActive(arg_9_0._goBuilding, false)
	arg_9_0:_initTask()
	arg_9_0:_initNpcNew()
end

function var_0_0._initNpc(arg_10_0)
	local var_10_0 = luaLang("survivalreportview_npc_empty")

	if arg_10_0._report ~= nil then
		local var_10_1 = arg_10_0._report.leaveNpcIds

		if var_10_1 ~= nil and #var_10_1 > 0 then
			local var_10_2 = #var_10_1
			local var_10_3 = ""

			for iter_10_0 = 1, var_10_2 do
				local var_10_4 = var_10_1[iter_10_0]
				local var_10_5 = SurvivalConfig.instance:getNpcConfig(var_10_4)

				if var_10_5 then
					local var_10_6 = var_10_5.name

					if iter_10_0 ~= var_10_2 then
						var_10_3 = var_10_3 .. var_10_6 .. luaLang("sep_overseas")
					else
						var_10_3 = var_10_3 .. var_10_6
					end
				end
			end

			var_10_0 = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survivalreportview_npc"), var_10_2, var_10_3)
		end
	end

	arg_10_0._txtNpc.text = var_10_0
end

function var_0_0._initNpcNew(arg_11_0)
	local var_11_0 = arg_11_0._report.npc2GetCount
	local var_11_1 = 0

	if var_11_0 then
		var_11_1 = tabletool.len(var_11_0)
	end

	local var_11_2 = SurvivalShelterTentListModel.instance:getShowList()
	local var_11_3 = true

	for iter_11_0, iter_11_1 in pairs(var_11_2) do
		if iter_11_1.buildingInfo and iter_11_1.buildingInfo:isBuild() and iter_11_1.npcNum < iter_11_1.npcCount then
			var_11_3 = false

			break
		end
	end

	local var_11_4 = var_11_1 > 0 and var_11_3

	gohelper.setActive(arg_11_0._goNpcNew, var_11_4)

	if var_11_4 then
		local var_11_5 = ""
		local var_11_6 = 0

		for iter_11_2, iter_11_3 in pairs(var_11_0) do
			var_11_6 = var_11_6 + 1

			local var_11_7 = SurvivalConfig.instance:getNpcConfig(tonumber(iter_11_2))

			if var_11_7 then
				var_11_5 = var_11_5 .. var_11_7.name .. (var_11_6 == var_11_1 and "" or ",")
			end
		end

		if not string.nilorempty(var_11_5) then
			arg_11_0._txtNpcNew.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survivalreportview_npc_new"), var_11_5)
		end
	end
end

function var_0_0._initMonster(arg_12_0)
	local var_12_0 = luaLang("survivalreportview_monster_empty")

	if arg_12_0._report ~= nil then
		local var_12_1 = SurvivalShelterModel.instance:getWeekInfo()
		local var_12_2 = var_12_1.intrudeBox

		if var_12_2 ~= nil then
			local var_12_3 = var_12_1.day + 1
			local var_12_4 = var_12_2:getNextBossCreateDay(var_12_3)

			if var_12_3 == var_12_4 then
				var_12_0 = luaLang("survivalreportview_monster_today")
			else
				var_12_0 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survivalreportview_monster"), var_12_4 - var_12_3)
			end
		end
	end

	arg_12_0._txtMonster.text = var_12_0
end

function var_0_0._initBuilding(arg_13_0)
	local var_13_0 = luaLang("survivalreportview_build_empty")

	if arg_13_0._report ~= nil then
		local var_13_1 = arg_13_0._report.desBuildingIds
		local var_13_2 = SurvivalShelterModel.instance:getWeekInfo()

		if var_13_1 ~= nil and #var_13_1 > 0 then
			local var_13_3 = #var_13_1
			local var_13_4 = ""

			for iter_13_0 = 1, var_13_3 do
				local var_13_5 = var_13_1[iter_13_0]
				local var_13_6 = var_13_2:getBuildingInfo(var_13_5)

				if var_13_6 then
					local var_13_7 = var_13_6.baseCo

					if var_13_7 then
						local var_13_8 = var_13_7.name

						if iter_13_0 ~= var_13_3 then
							var_13_4 = var_13_4 .. var_13_8 .. luaLang("sep_overseas")
						else
							var_13_4 = var_13_4 .. var_13_8
						end
					end
				end
			end

			if not string.nilorempty(var_13_4) then
				var_13_0 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survivalreportview_build"), var_13_4)
			end
		end
	end

	arg_13_0._txtBuilding.text = var_13_0
end

function var_0_0._initTask(arg_14_0)
	local var_14_0

	if arg_14_0._report ~= nil then
		local var_14_1 = arg_14_0._report.totalScore

		if var_14_1 ~= nil and var_14_1 > 0 then
			local var_14_2 = arg_14_0._report.itemId2Count
			local var_14_3 = arg_14_0._report.npc2GetCount
			local var_14_4 = 0

			if var_14_3 ~= nil then
				var_14_4 = tabletool.len(var_14_3)
			end

			local var_14_5 = 0
			local var_14_6 = 0
			local var_14_7 = 0
			local var_14_8 = 0
			local var_14_9 = 0

			for iter_14_0, iter_14_1 in pairs(var_14_2) do
				local var_14_10 = lua_survival_item.configDict[tonumber(iter_14_0)]

				if var_14_10 then
					if var_14_10.type == SurvivalEnum.ItemType.Equip then
						var_14_7 = var_14_7 + iter_14_1
					elseif var_14_10.type == SurvivalEnum.ItemType.Currency then
						if var_14_10.subType == SurvivalEnum.CurrencyType.Gold then
							var_14_8 = var_14_8 + iter_14_1
						elseif var_14_10.subType == SurvivalEnum.CurrencyType.Build then
							var_14_5 = var_14_5 + iter_14_1
						elseif var_14_10.subType == SurvivalEnum.CurrencyType.Food then
							var_14_6 = var_14_6 + iter_14_1
						else
							var_14_9 = var_14_9 + iter_14_1
						end
					else
						var_14_9 = var_14_9 + iter_14_1
					end
				end
			end

			local var_14_11 = ""

			local function var_14_12(arg_15_0, arg_15_1)
				if arg_15_0 > 0 then
					if var_14_11 ~= "" then
						var_14_11 = var_14_11 .. luaLang("sep_overseas")
					end

					var_14_11 = var_14_11 .. GameUtil.getSubPlaceholderLuaLangOneParam(luaLang(arg_15_1), arg_15_0)
				end
			end

			var_14_12(var_14_5, "survivalreportview_score_buildItem")
			var_14_12(var_14_6, "survivalreportview_score_foodItem")
			var_14_12(var_14_7, "survivalreportview_score_equipItem")
			var_14_12(var_14_8, "survivalreportview_score_goldItem")
			var_14_12(var_14_9, "survivalreportview_score_otherItem")
			var_14_12(var_14_4, "survivalreportview_score_npc")

			if not string.nilorempty(var_14_11) then
				local var_14_13 = "survivalreportview_score_failed"

				if SurvivalMapModel.instance.result == SurvivalEnum.MapResult.Win then
					var_14_13 = "survivalreportview_score_success"
				end

				var_14_0 = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang(var_14_13), var_14_11, var_14_1)
			end
		end
	end

	if var_14_0 ~= nil then
		arg_14_0._txtTask.text = var_14_0
		arg_14_0._txtnpcScore.text = arg_14_0._report.totalScore
	end

	gohelper.setActive(arg_14_0._goTask, var_14_0 ~= nil)
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0
