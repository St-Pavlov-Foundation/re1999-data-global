module("modules.logic.fight.view.FightBuffTipsView", package.seeall)

local var_0_0 = class("FightBuffTipsView", BaseView)

function var_0_0._setPos(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.viewParam.iconPos
	local var_1_1 = arg_1_0.viewParam.offsetX
	local var_1_2 = arg_1_0.viewParam.offsetY

	arg_1_0.enemyBuffTipPosY = 80

	local var_1_3 = recthelper.rectToRelativeAnchorPos(var_1_0, arg_1_0._gobuffinfocontainer.transform.parent)
	local var_1_4 = recthelper.getWidth(arg_1_0._scrollbuff.transform)
	local var_1_5 = recthelper.getHeight(arg_1_0._scrollbuff.transform)
	local var_1_6 = 0
	local var_1_7 = 0

	if arg_1_1.side == FightEnum.EntitySide.MySide then
		var_1_6 = var_1_3.x - var_1_1
		var_1_7 = var_1_3.y + var_1_2
	else
		var_1_6 = var_1_3.x + var_1_1
		var_1_7 = arg_1_0.enemyBuffTipPosY
	end

	local var_1_8 = UnityEngine.Screen.width * 0.5
	local var_1_9 = 10
	local var_1_10 = {
		min = -var_1_8 + var_1_4 + var_1_9,
		max = var_1_8 - var_1_4 - var_1_9
	}
	local var_1_11 = GameUtil.clamp(var_1_6, var_1_10.min, var_1_10.max)

	recthelper.setAnchor(arg_1_0._gobuffinfocontainer.transform, var_1_11, var_1_7)
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._gobuffinfocontainer = gohelper.findChild(arg_2_0.viewGO, "root/#go_buffinfocontainer/buff")
	arg_2_0._scrollbuff = gohelper.findChildScrollRect(arg_2_0.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff")
	arg_2_0._gobuffitem = gohelper.findChild(arg_2_0.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content/#go_buffitem")
	arg_2_0._btnclosebuffinfocontainer = gohelper.findChildButton(arg_2_0.viewGO, "root/#go_buffinfocontainer/#btn_click")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnclosebuffinfocontainer:AddClickListener(arg_3_0._onCloseBuffInfoContainer, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnclosebuffinfocontainer:RemoveClickListener()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.rectTrScrollBuff = arg_5_0._scrollbuff:GetComponent(gohelper.Type_RectTransform)
	arg_5_0.rectTrBuffContent = gohelper.findChildComponent(arg_5_0.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content", gohelper.Type_RectTransform)

	gohelper.setActive(arg_5_0._gobuffitem, false)

	arg_5_0._buffItemList = {}
end

function var_0_0._onCloseBuffInfoContainer(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_click)
	arg_6_0:closeThis()
end

function var_0_0.onOpen(arg_7_0)
	gohelper.setActive(gohelper.findChild(arg_7_0.viewGO, "root/tips"), true)

	local var_7_0 = FightDataHelper.entityMgr:getById(arg_7_0.viewParam.entityId or arg_7_0.viewParam)

	arg_7_0:_updateBuffs(var_7_0)

	if arg_7_0.viewParam.viewname and arg_7_0.viewParam.viewname == "FightView" then
		arg_7_0:_setPos(var_7_0)
	else
		local var_7_1 = var_7_0.side == FightEnum.EntitySide.MySide and 207 or -161

		recthelper.setAnchorX(arg_7_0._gobuffinfocontainer.transform, var_7_1)
	end
end

function var_0_0._setPos(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.viewParam.iconPos
	local var_8_1 = arg_8_0.viewParam.offsetX
	local var_8_2 = arg_8_0.viewParam.offsetY

	arg_8_0.enemyBuffTipPosY = 80

	local var_8_3 = recthelper.rectToRelativeAnchorPos(var_8_0, arg_8_0._gobuffinfocontainer.transform.parent)
	local var_8_4 = recthelper.getWidth(arg_8_0.rectTrScrollBuff)
	local var_8_5 = recthelper.getHeight(arg_8_0.rectTrScrollBuff)
	local var_8_6 = 0
	local var_8_7 = 0

	if arg_8_1.side == FightEnum.EntitySide.MySide then
		var_8_6 = var_8_3.x - var_8_1
		var_8_7 = var_8_3.y + var_8_2
	else
		var_8_6 = var_8_3.x + var_8_1
		var_8_7 = arg_8_0.enemyBuffTipPosY
	end

	local var_8_8 = UnityEngine.Screen.width * 0.5
	local var_8_9 = 10
	local var_8_10 = {
		min = -var_8_8 + var_8_4 + var_8_9,
		max = var_8_8 - var_8_4 - var_8_9
	}
	local var_8_11 = GameUtil.clamp(var_8_6, var_8_10.min, var_8_10.max)

	recthelper.setAnchor(arg_8_0._gobuffinfocontainer.transform, var_8_11, var_8_7)
end

function var_0_0._updateBuffs(arg_9_0, arg_9_1)
	arg_9_0:updateBuffDesc(arg_9_1, arg_9_0._buffItemList, arg_9_0._gobuffitem, arg_9_0, arg_9_0.getCommonBuffTipScrollAnchor)
end

var_0_0.Interval = 10

function var_0_0.getCommonBuffTipScrollAnchor(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = GameUtil.getViewSize() / 2
	local var_10_1 = arg_10_0.rectTrScrollBuff
	local var_10_2 = arg_10_0.rectTrBuffContent
	local var_10_3, var_10_4 = recthelper.uiPosToScreenPos2(var_10_1)
	local var_10_5, var_10_6 = SLFramework.UGUI.RectTrHelper.ScreenPosXYToAnchorPosXY(var_10_3, var_10_4, arg_10_1, CameraMgr.instance:getUICamera(), nil, nil)
	local var_10_7 = recthelper.getWidth(var_10_1) / 2
	local var_10_8 = var_10_0 + var_10_5 - var_10_7 - var_0_0.Interval
	local var_10_9 = recthelper.getWidth(arg_10_2)
	local var_10_10 = var_10_9 <= var_10_8

	arg_10_2.pivot = CommonBuffTipEnum.Pivot.Right

	local var_10_11 = var_10_5
	local var_10_12 = var_10_6

	if var_10_10 then
		var_10_11 = var_10_11 - var_10_7 - var_0_0.Interval
	else
		var_10_11 = var_10_11 + var_10_7 + var_0_0.Interval + var_10_9
	end

	local var_10_13 = math.min(recthelper.getHeight(var_10_1), recthelper.getHeight(var_10_2)) / 2

	recthelper.setAnchor(arg_10_2, var_10_11, var_10_12 + var_10_13)
end

var_0_0.filterTypeKey = {
	[2] = true
}

local var_0_1 = 635
local var_0_2 = 597
local var_0_3 = 300
local var_0_4 = 141

function var_0_0.updateBuffDesc(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	local var_11_0 = arg_11_1 and arg_11_1:getBuffList() or {}
	local var_11_1 = tabletool.copy(var_11_0)
	local var_11_2 = FightBuffHelper.filterBuffType(var_11_1, var_0_0.filterTypeKey)

	FightSkillBuffMgr.instance:dealStackerBuff(var_11_2)
	table.sort(var_11_2, function(arg_12_0, arg_12_1)
		if arg_12_0.time ~= arg_12_1.time then
			return arg_12_0.time < arg_12_1.time
		end

		return arg_12_0.id < arg_12_1.id
	end)

	for iter_11_0, iter_11_1 in ipairs(arg_11_2) do
		gohelper.setActive(iter_11_1.go, false)
	end

	local var_11_3 = var_11_2 and #var_11_2 or 0
	local var_11_4 = 0
	local var_11_5 = -1
	local var_11_6 = var_0_1
	local var_11_7 = var_0_2
	local var_11_8 = {}

	for iter_11_2 = 1, var_11_3 do
		local var_11_9 = var_11_2[iter_11_2]
		local var_11_10 = lua_skill_buff.configDict[var_11_9.buffId]

		if var_11_10 and var_11_10.isNoShow == 0 then
			local var_11_11 = lua_skill_bufftype.configDict[var_11_10.typeId]
			local var_11_12 = lua_skill_buff_desc.configDict[var_11_11.type]

			var_11_4 = var_11_4 + 1

			local var_11_13 = arg_11_2[var_11_4]

			if not var_11_13 then
				var_11_13 = arg_11_4:getUserDataTb_()
				var_11_13.go = gohelper.cloneInPlace(arg_11_3, "buff" .. var_11_4)
				var_11_13.getAnchorFunc = arg_11_5
				var_11_13.viewClass = arg_11_4

				table.insert(arg_11_2, var_11_13)
			end

			local var_11_14 = var_11_13.go

			var_11_5 = #arg_11_2

			local var_11_15 = gohelper.findChildText(var_11_14, "title/txt_time")
			local var_11_16 = gohelper.findChildText(var_11_14, "txt_desc")

			SkillHelper.addHyperLinkClick(var_11_16, var_0_0.onClickBuffHyperLink, var_11_13)

			local var_11_17 = var_11_16.transform
			local var_11_18 = gohelper.findChild(var_11_14, "title").transform
			local var_11_19 = gohelper.findChildText(var_11_14, "title/txt_name")
			local var_11_20 = gohelper.findChildImage(var_11_14, "title/simage_icon")
			local var_11_21 = gohelper.findChild(var_11_14, "txt_desc/image_line")
			local var_11_22 = gohelper.findChild(var_11_14, "title/txt_name/go_tag")
			local var_11_23 = gohelper.findChildText(var_11_14, "title/txt_name/go_tag/bg/txt_tagname")
			local var_11_24 = var_11_14.transform

			gohelper.setActive(var_11_14, true)
			gohelper.setActive(var_11_21, var_11_4 ~= var_11_3)

			var_11_8[#var_11_8 + 1] = var_11_17
			var_11_8[#var_11_8 + 1] = var_11_18
			var_11_8[#var_11_8 + 1] = var_11_24
			var_11_8[#var_11_8 + 1] = var_11_16
			var_11_8[#var_11_8 + 1] = var_11_9

			var_0_0.showBuffTime(var_11_15, var_11_9, var_11_10, arg_11_1)

			var_11_19.text = var_0_0.getBuffName(var_11_9, var_11_10)

			local var_11_25 = var_11_19.preferredWidth

			if var_11_20 then
				UISpriteSetMgr.instance:setBuffSprite(var_11_20, var_11_10.iconId)
			end

			if var_11_12 then
				var_11_23.text = var_11_12.name
				var_11_25 = var_11_25 + var_11_23.preferredWidth
			end

			local var_11_26 = var_11_15.preferredWidth

			if var_11_26 > var_0_4 then
				var_11_25 = var_11_25 + math.max(0, var_11_26 - var_0_4)
			end

			if var_11_25 > var_0_3 then
				local var_11_27 = var_11_25 - var_0_3
				local var_11_28 = var_0_2 + var_11_27

				var_11_6 = math.max(var_11_6, var_11_28)
				var_11_7 = math.max(var_11_7, var_11_28)
			end

			gohelper.setActive(var_11_22, var_11_12)
		end
	end

	if #var_11_8 > 0 then
		for iter_11_3 = 0, #var_11_8 - 1, 5 do
			local var_11_29 = var_11_8[iter_11_3 + 1]
			local var_11_30 = var_11_8[iter_11_3 + 2]
			local var_11_31 = var_11_8[iter_11_3 + 3]
			local var_11_32 = var_11_8[iter_11_3 + 4]
			local var_11_33 = var_11_8[iter_11_3 + 5]
			local var_11_34 = var_11_33.buffId
			local var_11_35 = lua_skill_buff.configDict[var_11_34]

			recthelper.setWidth(var_11_30, var_11_7 - 10)
			recthelper.setWidth(var_11_29, var_11_7 - 46)
			ZProj.UGUIHelper.RebuildLayout(var_11_31)
			recthelper.setWidth(var_11_31, var_11_7)

			var_11_32.text = FightBuffGetDescHelper.getBuffDesc(var_11_33)
			var_11_32.text = var_11_32.text

			local var_11_36 = var_11_32.preferredHeight + 52.1 + 10

			recthelper.setHeight(var_11_31, var_11_36)
		end
	end

	for iter_11_4 in pairs(var_11_8) do
		rawset(var_11_8, iter_11_4, nil)
	end

	local var_11_37

	if var_11_5 ~= -1 then
		local var_11_38 = arg_11_2[var_11_5].go
		local var_11_39 = gohelper.findChild(var_11_38, "txt_desc/image_line")

		gohelper.setActive(var_11_39, false)
	end

	if arg_11_4 then
		arg_11_4._scrollbuff.verticalNormalizedPosition = 1

		recthelper.setWidth(arg_11_4._scrollbuff.transform, var_11_6)
	end
end

function var_0_0.onClickBuffHyperLink(arg_13_0, arg_13_1, arg_13_2)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPosCallback(arg_13_1, arg_13_0.getAnchorFunc, arg_13_0.viewClass)
end

function var_0_0.getBuffName(arg_14_0, arg_14_1)
	if FightHeroSpEffectConfig.instance:isKSDLSpecialBuff(arg_14_0.buffId) then
		return var_0_0.getKSDLBuffName(arg_14_0, arg_14_1)
	end

	return arg_14_1.name
end

function var_0_0.showBuffTime(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if FightHeroSpEffectConfig.instance:isKSDLSpecialBuff(arg_15_1.buffId) then
		arg_15_0.text = ""

		return
	end

	if FightBuffHelper.isCountContinueChanelBuff(arg_15_1) then
		arg_15_0.text = string.format(luaLang("enemytip_buff_time"), arg_15_1.exInfo)

		return
	end

	if arg_15_1 and FightConfig.instance:hasBuffFeature(arg_15_1.buffId, FightEnum.BuffFeature.CountUseSelfSkillContinueChannel) then
		arg_15_0.text = string.format(luaLang("enemytip_buff_time"), arg_15_1.exInfo)

		return
	end

	if FightBuffHelper.isDuduBoneContinueChannelBuff(arg_15_1) then
		arg_15_0.text = string.format(luaLang("buff_tip_duration"), arg_15_1.exInfo)

		return
	end

	if FightBuffHelper.isDeadlyPoisonBuff(arg_15_1) then
		local var_15_0 = FightSkillBuffMgr.instance:getStackedCount(arg_15_1.entityId, arg_15_1)

		arg_15_0.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("buff_tip_round_and_layer"), arg_15_1.duration, var_15_0)

		return
	end

	local var_15_1 = lua_skill_bufftype.configDict[arg_15_2.typeId]
	local var_15_2, var_15_3 = FightSkillBuffMgr.instance:buffIsStackerBuff(arg_15_2)

	if var_15_2 then
		local var_15_4 = string.format(luaLang("enemytip_buff_stacked_count"), FightSkillBuffMgr.instance:getStackedCount(arg_15_3.id, arg_15_1))

		if var_15_3 == FightEnum.BuffIncludeTypes.Stacked12 then
			arg_15_0.text = var_15_4 .. " " .. string.format(luaLang("enemytip_buff_time"), arg_15_1.duration)
		else
			arg_15_0.text = var_15_4
		end
	elseif arg_15_1.duration == 0 then
		if arg_15_1.count == 0 then
			arg_15_0.text = luaLang("forever")
		else
			local var_15_5 = arg_15_1.count
			local var_15_6 = "enemytip_buff_count"
			local var_15_7 = var_15_1 and var_15_1.includeTypes or ""

			if string.split(var_15_7, "#")[1] == "11" then
				var_15_6 = "enemytip_buff_stacked_count"
				var_15_5 = arg_15_1.layer
			end

			arg_15_0.text = string.format(luaLang(var_15_6), var_15_5)
		end
	elseif arg_15_1.count == 0 then
		arg_15_0.text = string.format(luaLang("enemytip_buff_time"), arg_15_1.duration)
	else
		local var_15_8 = arg_15_1.count
		local var_15_9 = "round_or_times"
		local var_15_10 = var_15_1 and var_15_1.includeTypes or ""

		if string.split(var_15_10, "#")[1] == "11" then
			var_15_9 = "round_or_stacked_count"
			var_15_8 = arg_15_1.layer
		end

		local var_15_11 = {
			arg_15_1.duration,
			var_15_8
		}

		arg_15_0.text = GameUtil.getSubPlaceholderLuaLang(luaLang(var_15_9), var_15_11)
	end
end

function var_0_0.getKSDLBuffName(arg_16_0, arg_16_1)
	arg_16_0 = FightBuffHelper.getKSDLSpecialBuffList(arg_16_0)[1]

	if not arg_16_0 then
		return arg_16_1.name
	end

	arg_16_1 = arg_16_0:getCO()

	return arg_16_1.name
end

return var_0_0
