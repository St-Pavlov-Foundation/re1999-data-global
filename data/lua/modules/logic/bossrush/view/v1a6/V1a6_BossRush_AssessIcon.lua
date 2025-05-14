module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_AssessIcon", package.seeall)

local var_0_0 = class("V1a6_BossRush_AssessIcon", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goAssessEmpty = gohelper.findChild(arg_1_0.viewGO, "#go_AssessEmpty")
	arg_1_0._goNotEmpty = gohelper.findChild(arg_1_0.viewGO, "#go_NotEmpty")
	arg_1_0._imageAssessIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_NotEmpty/#image_AssessIcon")
	arg_1_0._txtScore = gohelper.findChildText(arg_1_0.viewGO, "Score/#txt_Score")
	arg_1_0._txtScoreNum = gohelper.findChildText(arg_1_0.viewGO, "Score/#txt_ScoreNum")

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
	arg_4_0._goScore = gohelper.findChild(arg_4_0.viewGO, "Score")

	gohelper.setActive(arg_4_0._goScore, false)
	arg_4_0:initVX()
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	return
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0._imageAssessIcon:UnLoadImage()
end

function var_0_0.init(arg_9_0, arg_9_1)
	arg_9_0.viewGO = arg_9_1

	arg_9_0:onInitView()
end

function var_0_0.setData(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if arg_10_1 and arg_10_2 then
		local var_10_0, var_10_1, var_10_2 = BossRushConfig.instance:getAssessSpriteName(arg_10_1, arg_10_2, arg_10_3)
		local var_10_3 = string.nilorempty(var_10_0)

		gohelper.setActive(arg_10_0._goNotEmpty, not var_10_3)
		gohelper.setActive(arg_10_0._goAssessEmpty, var_10_3)

		if not var_10_3 then
			local var_10_4 = gohelper.findChildImage(arg_10_0.viewGO, "#go_NotEmpty/#image_AssessIcon")

			if not arg_10_4 then
				local var_10_5 = arg_10_3 and 1.2 or 1

				transformhelper.setLocalScale(arg_10_0._imageAssessIcon.transform, var_10_5, var_10_5, var_10_5)
			end

			arg_10_0._imageAssessIcon:LoadImage(ResUrl.getV1a4BossRushAssessIcon(var_10_0), function()
				if arg_10_4 then
					var_10_4:SetNativeSize()
				end
			end)
			arg_10_0:showVX(var_10_1)

			if var_10_1 > 0 then
				AudioMgr.instance:trigger(AudioEnum.ui_settleaccounts.play_ui_settleaccounts_resources_rare)
			end

			return var_10_0, var_10_1, var_10_2
		end
	end
end

function var_0_0.initVX(arg_12_0)
	arg_12_0.vxassess = {
		[BossRushEnum.ScoreLevel.S] = gohelper.findChild(arg_12_0._imageAssessIcon.gameObject, "vx_s"),
		[BossRushEnum.ScoreLevel.S_A] = gohelper.findChild(arg_12_0._imageAssessIcon.gameObject, "vx_ss"),
		[BossRushEnum.ScoreLevel.S_AA] = gohelper.findChild(arg_12_0._imageAssessIcon.gameObject, "vx_sss"),
		[BossRushEnum.ScoreLevel.S_AAA] = gohelper.findChild(arg_12_0._imageAssessIcon.gameObject, "vx_sss2")
	}

	arg_12_0:showVX(false)
end

function var_0_0.showVX(arg_13_0, arg_13_1)
	if arg_13_0.vxassess then
		for iter_13_0, iter_13_1 in pairs(arg_13_0.vxassess) do
			gohelper.setActive(iter_13_1, arg_13_1 == iter_13_0)
		end
	end
end

return var_0_0
