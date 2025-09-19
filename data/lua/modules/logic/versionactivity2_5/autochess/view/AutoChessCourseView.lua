module("modules.logic.versionactivity2_5.autochess.view.AutoChessCourseView", package.seeall)

local var_0_0 = class("AutoChessCourseView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goBadge = gohelper.findChild(arg_1_0.viewGO, "root/#go_Badge")
	arg_1_0._txtAllWinCnt = gohelper.findChildText(arg_1_0.viewGO, "root/right/item1/#txt_AllWinCnt")
	arg_1_0._txtPlayRound = gohelper.findChildText(arg_1_0.viewGO, "root/right/item2/#txt_PlayRound")
	arg_1_0._txtAllDamage = gohelper.findChildText(arg_1_0.viewGO, "root/right/item3/#txt_AllDamage")
	arg_1_0._txtChessCnt = gohelper.findChildText(arg_1_0.viewGO, "root/right/item4/#txt_ChessCnt")
	arg_1_0._goChessItem = gohelper.findChild(arg_1_0.viewGO, "root/right/Chess/scroll_Chess/viewport/content/#go_ChessItem")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "root/#go_topleft")

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

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.actMo = Activity182Model.instance:getActMo()
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_details_open)

	local var_6_0 = arg_6_0.actMo.historyInfo
	local var_6_1 = arg_6_0:getResInst(AutoChessStrEnum.ResPath.BadgeItem, arg_6_0._goBadge)

	MonoHelper.addNoUpdateLuaComOnceToGo(var_6_1, AutoChessBadgeItem, arg_6_0):setData(var_6_0.maxRank, 99999, AutoChessBadgeItem.ShowType.CourseView)

	arg_6_0._txtAllWinCnt.text = var_6_0.winCount
	arg_6_0._txtPlayRound.text = var_6_0.survivalTotalRound
	arg_6_0._txtAllDamage.text = var_6_0.totalHurt

	local var_6_2 = GameUtil.splitString2(var_6_0.autoChessCount, true)

	if var_6_2 then
		table.sort(var_6_2, function(arg_7_0, arg_7_1)
			return arg_7_0[2] > arg_7_1[2]
		end)

		for iter_6_0, iter_6_1 in ipairs(var_6_2) do
			local var_6_3 = AutoChessConfig.instance:getChessCfgById(iter_6_1[1])
			local var_6_4, var_6_5 = next(var_6_3)

			if var_6_5 then
				local var_6_6 = gohelper.cloneInPlace(arg_6_0._goChessItem)
				local var_6_7 = gohelper.findChildImage(var_6_6, "image_Bg")

				if var_6_5.type == AutoChessStrEnum.ChessType.Attack then
					UISpriteSetMgr.instance:setAutoChessSprite(var_6_7, "v2a5_autochess_quality1_" .. var_6_5.levelFromMall)
				else
					UISpriteSetMgr.instance:setAutoChessSprite(var_6_7, "v2a5_autochess_quality2_" .. var_6_5.levelFromMall)
				end

				local var_6_8 = gohelper.findChild(var_6_6, "Mesh")

				MonoHelper.addNoUpdateLuaComOnceToGo(var_6_8, AutoChessMeshComp):setData(var_6_5.image)
				gohelper.setActive(var_6_6, true)
			end
		end

		arg_6_0._txtChessCnt.text = #var_6_2
	else
		arg_6_0._txtChessCnt.text = 0
	end
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
