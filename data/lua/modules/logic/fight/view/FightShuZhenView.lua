module("modules.logic.fight.view.FightShuZhenView", package.seeall)

local var_0_0 = class("FightShuZhenView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._topLeftRoot = gohelper.findChild(arg_1_0.viewGO, "root/topLeftContent")
	arg_1_0._obj = gohelper.findChild(arg_1_0.viewGO, "root/topLeftContent/#go_shuzhentips")
	arg_1_0._detail = gohelper.findChild(arg_1_0.viewGO, "root/#go_shuzhendetails")
	gohelper.onceAddComponent(arg_1_0._detail, typeof(UnityEngine.Animator)).enabled = true
	arg_1_0._text = gohelper.findChildText(arg_1_0._obj, "layout/shuzhenitem/#txt_task")
	arg_1_0._red = gohelper.findChild(arg_1_0._obj, "layout/shuzhenitem/#txt_task/red")
	arg_1_0._blue = gohelper.findChild(arg_1_0._obj, "layout/shuzhenitem/#txt_task/blue")
	arg_1_0._red_round_num = gohelper.findChildText(arg_1_0._obj, "layout/shuzhenitem/#txt_task/red/#txt_num")
	arg_1_0._blue_round_num = gohelper.findChildText(arg_1_0._obj, "layout/shuzhenitem/#txt_task/blue/#txt_num")
	arg_1_0._detailHeightObj = gohelper.findChild(arg_1_0.viewGO, "root/#go_shuzhendetails/details")
	arg_1_0._detailTitle = gohelper.findChildText(arg_1_0.viewGO, "root/#go_shuzhendetails/details/#scroll_details/Viewport/Content/#txt_title")
	arg_1_0._detailRound = gohelper.findChildText(arg_1_0.viewGO, "root/#go_shuzhendetails/details/#scroll_details/Viewport/Content/#txt_title/#txt_round")
	arg_1_0._detailText = gohelper.findChildText(arg_1_0.viewGO, "root/#go_shuzhendetails/details/#scroll_details/Viewport/Content/#txt_details")
	arg_1_0._click = gohelper.getClickWithDefaultAudio(gohelper.findChild(arg_1_0._obj, "layout/shuzhenitem"))
	arg_1_0._detailClick = gohelper.getClickWithDefaultAudio(gohelper.findChild(arg_1_0._detail, "#btn_shuzhendetailclick"))
	arg_1_0._ani = gohelper.findChildComponent(arg_1_0._obj, "layout/shuzhenitem", typeof(UnityEngine.Animator))
	arg_1_0._aniPlayer = SLFramework.AnimatorPlayer.Get(arg_1_0._ani.gameObject)
	arg_1_0._redUpdate = gohelper.findChild(arg_1_0._obj, "layout/shuzhenitem/update_red")
	arg_1_0._blueUpdate = gohelper.findChild(arg_1_0._obj, "layout/shuzhenitem/update_blue")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClick, arg_2_0)
	arg_2_0._detailClick:AddClickListener(arg_2_0._onDetailClick, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.AddMagicCircile, arg_2_0._onAddMagicCircile, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.DeleteMagicCircile, arg_2_0._onDeleteMagicCircile, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.UpdateMagicCircile, arg_2_0._onUpdateMagicCircile, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._click:RemoveClickListener()
	arg_3_0._detailClick:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._text.text = ""

	gohelper.setActive(arg_4_0._obj, false)
	gohelper.setActive(arg_4_0._detail, false)
	SkillHelper.addHyperLinkClick(arg_4_0._detailText, arg_4_0.onClickShuZhenHyperDesc, arg_4_0)

	arg_4_0.detailRectTr = arg_4_0._detail:GetComponent(gohelper.Type_RectTransform)
	arg_4_0.viewGoRectTr = arg_4_0.viewGO:GetComponent(gohelper.Type_RectTransform)
	arg_4_0.scrollRectTr = gohelper.findChildComponent(arg_4_0.viewGO, "root/#go_shuzhendetails/details/#scroll_details", gohelper.Type_RectTransform)
end

var_0_0.TipIntervalX = 10

function var_0_0.onClickShuZhenHyperDesc(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = recthelper.getWidth(arg_5_0.viewGoRectTr) / 2
	local var_5_1 = recthelper.getAnchorX(arg_5_0.detailRectTr)
	local var_5_2 = recthelper.getWidth(arg_5_0.scrollRectTr)
	local var_5_3 = var_5_0 - var_5_1 - var_5_2 - var_0_0.TipIntervalX

	arg_5_0.commonBuffTipAnchorPos = arg_5_0.commonBuffTipAnchorPos or Vector2()

	arg_5_0.commonBuffTipAnchorPos:Set(-var_5_3, 312.24)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(arg_5_1, arg_5_0.commonBuffTipAnchorPos, CommonBuffTipEnum.Pivot.Left)
end

function var_0_0._onClick(arg_6_0)
	local var_6_0 = recthelper.rectToRelativeAnchorPos(arg_6_0._text.transform.position, arg_6_0._topLeftRoot.transform).y - arg_6_0._text.preferredHeight + recthelper.getAnchorY(arg_6_0._topLeftRoot.transform)

	recthelper.setAnchorY(arg_6_0._detail.transform, var_6_0)
	gohelper.setActive(arg_6_0._detail, true)
end

function var_0_0._onDetailClick(arg_7_0)
	gohelper.setActive(arg_7_0._detail, false)
end

function var_0_0.onOpen(arg_8_0)
	local var_8_0 = FightModel.instance:getMagicCircleInfo()

	if var_8_0 and var_8_0.magicCircleId then
		local var_8_1 = lua_magic_circle.configDict[var_8_0.magicCircleId]

		if var_8_1 then
			gohelper.setActive(arg_8_0._obj, true)

			arg_8_0._text.text = var_8_1.name

			local var_8_2 = FightHelper.getMagicSide(var_8_0.createUid)

			gohelper.setActive(arg_8_0._red, var_8_2 == FightEnum.EntitySide.EnemySide)
			gohelper.setActive(arg_8_0._blue, var_8_2 == FightEnum.EntitySide.MySide)

			local var_8_3 = var_8_2 == FightEnum.EntitySide.MySide and "#547ca6" or "#9f4f4f"

			SLFramework.UGUI.GuiHelper.SetColor(arg_8_0._text, var_8_3)

			local var_8_4 = var_8_0.round == -1 and "∞" or var_8_0.round

			arg_8_0._red_round_num.text = var_8_4
			arg_8_0._blue_round_num.text = var_8_4
			arg_8_0._detailTitle.text = var_8_1.name
			arg_8_0._detailRound.text = formatLuaLang("x_round", var_8_4)
			arg_8_0._detailText.text = SkillHelper.buildDesc(var_8_1.desc)
			arg_8_0._curSide = var_8_2

			return
		end
	end
end

function var_0_0._onAddMagicCircile(arg_9_0)
	arg_9_0:onOpen()
	arg_9_0:_playAni("open")
end

function var_0_0._onDeleteMagicCircile(arg_10_0)
	arg_10_0:_playAni("close", arg_10_0._hideObj, arg_10_0)
end

function var_0_0._hideObj(arg_11_0)
	gohelper.setActive(arg_11_0._obj, false)
end

function var_0_0._onUpdateMagicCircile(arg_12_0)
	arg_12_0:onOpen()

	local var_12_0 = FightModel.instance:getMagicCircleInfo()

	if var_12_0 and var_12_0.magicCircleId and var_12_0.round == -1 then
		return
	end

	if arg_12_0._curSide == FightEnum.EntitySide.MySide then
		gohelper.setActive(arg_12_0._blueUpdate, false)
		gohelper.setActive(arg_12_0._blueUpdate, true)
	else
		gohelper.setActive(arg_12_0._redUpdate, false)
		gohelper.setActive(arg_12_0._redUpdate, true)
	end
end

function var_0_0._playAni(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	gohelper.setActive(arg_13_0._obj, true)

	arg_13_0._ani.speed = FightModel.instance:getSpeed()

	arg_13_0._aniPlayer:Play(arg_13_1, arg_13_2, arg_13_3)
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0
