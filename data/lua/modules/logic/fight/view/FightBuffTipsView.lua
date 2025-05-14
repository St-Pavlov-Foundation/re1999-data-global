module("modules.logic.fight.view.FightBuffTipsView", package.seeall)

local var_0_0 = class("FightBuffTipsView", BaseView)
local var_0_1 = 635
local var_0_2 = 597
local var_0_3 = 300
local var_0_4 = 141

function var_0_0._updateBuffDesc_overseas(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = arg_1_0 and arg_1_0:getBuffList() or {}
	local var_1_1 = tabletool.copy(var_1_0)
	local var_1_2 = FightBuffHelper.filterBuffType(var_1_1, var_0_0.filterTypeKey)

	FightSkillBuffMgr.instance:dealStackerBuff(var_1_2)
	table.sort(var_1_2, function(arg_2_0, arg_2_1)
		if arg_2_0.time ~= arg_2_1.time then
			return arg_2_0.time < arg_2_1.time
		end

		return arg_2_0.id < arg_2_1.id
	end)

	for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
		gohelper.setActive(iter_1_1.go, false)
	end

	local var_1_3 = var_1_2 and #var_1_2 or 0
	local var_1_4 = 0
	local var_1_5 = -1
	local var_1_6 = var_0_1
	local var_1_7 = var_0_2
	local var_1_8 = {}

	for iter_1_2 = 1, var_1_3 do
		local var_1_9 = var_1_2[iter_1_2]
		local var_1_10 = lua_skill_buff.configDict[var_1_9.buffId]

		if var_1_10 and var_1_10.isNoShow == 0 then
			var_1_4 = var_1_4 + 1

			local var_1_11 = arg_1_1[var_1_4]

			if not var_1_11 then
				var_1_11 = arg_1_3:getUserDataTb_()
				var_1_11.go = gohelper.cloneInPlace(arg_1_2, "buff" .. var_1_4)
				var_1_11.getAnchorFunc = arg_1_4
				var_1_11.viewClass = arg_1_3

				table.insert(arg_1_1, var_1_11)
			end

			local var_1_12 = var_1_11.go

			var_1_5 = #arg_1_1

			local var_1_13 = gohelper.findChildText(var_1_12, "title/txt_time")
			local var_1_14 = gohelper.findChildText(var_1_12, "txt_desc")

			SkillHelper.addHyperLinkClick(var_1_14, var_0_0.onClickBuffHyperLink, var_1_11)

			local var_1_15 = var_1_14.transform
			local var_1_16 = gohelper.findChild(var_1_12, "title")
			local var_1_17 = var_1_16.transform
			local var_1_18 = gohelper.findChildText(var_1_16, "txt_name")
			local var_1_19 = gohelper.findChildImage(var_1_12, "title/simage_icon")
			local var_1_20 = gohelper.findChild(var_1_12, "txt_desc/image_line")
			local var_1_21 = gohelper.findChild(var_1_16, "txt_name/go_tag")
			local var_1_22 = gohelper.findChildText(var_1_21, "bg/txt_tagname")
			local var_1_23 = var_1_12.transform

			gohelper.setActive(var_1_12, true)
			gohelper.setActive(var_1_20, true)

			var_1_8[#var_1_8 + 1] = var_1_15
			var_1_8[#var_1_8 + 1] = var_1_17
			var_1_8[#var_1_8 + 1] = var_1_23
			var_1_8[#var_1_8 + 1] = var_1_14
			var_1_8[#var_1_8 + 1] = var_1_9

			local var_1_24 = lua_skill_bufftype.configDict[var_1_10.typeId]
			local var_1_25 = lua_skill_buff_desc.configDict[var_1_24.type]

			var_0_0.showBuffTime(var_1_13, var_1_9, var_1_10, arg_1_0)

			var_1_18.text = var_1_10.name

			local var_1_26 = var_1_18.preferredWidth

			if var_1_19 then
				UISpriteSetMgr.instance:setBuffSprite(var_1_19, var_1_10.iconId)
			end

			if var_1_25 then
				var_1_22.text = var_1_25.name
				var_1_26 = var_1_26 + var_1_22.preferredWidth
			end

			local var_1_27 = var_1_13.preferredWidth

			if var_1_27 > var_0_4 then
				var_1_26 = var_1_26 + math.max(0, var_1_27 - var_0_4)
			end

			if var_1_26 > var_0_3 then
				local var_1_28 = var_1_26 - var_0_3
				local var_1_29 = var_0_2 + var_1_28

				var_1_6 = math.max(var_1_6, var_1_29)
				var_1_7 = math.max(var_1_7, var_1_29)
			end

			gohelper.setActive(var_1_21, var_1_25)
		end
	end

	if #var_1_8 > 0 then
		for iter_1_3 = 0, #var_1_8 - 1, 5 do
			local var_1_30 = var_1_8[iter_1_3 + 1]
			local var_1_31 = var_1_8[iter_1_3 + 2]
			local var_1_32 = var_1_8[iter_1_3 + 3]
			local var_1_33 = var_1_8[iter_1_3 + 4]
			local var_1_34 = var_1_8[iter_1_3 + 5]
			local var_1_35 = var_1_34.buffId
			local var_1_36 = lua_skill_buff.configDict[var_1_35]

			recthelper.setWidth(var_1_31, var_1_7 - 10)
			recthelper.setWidth(var_1_30, var_1_7 - 46)
			ZProj.UGUIHelper.RebuildLayout(var_1_32)
			recthelper.setWidth(var_1_32, var_1_7)

			var_1_33.text = FightBuffGetDescHelper.getBuffDesc(var_1_34)
			var_1_33.text = var_1_33.text

			local var_1_37 = var_1_33.preferredHeight + 52.1 + 10

			recthelper.setHeight(var_1_32, var_1_37)
		end
	end

	for iter_1_4 in pairs(var_1_8) do
		rawset(var_1_8, iter_1_4, nil)
	end

	local var_1_38

	if var_1_5 ~= -1 then
		local var_1_39 = arg_1_1[var_1_5].go
		local var_1_40 = gohelper.findChild(var_1_39, "txt_desc/image_line")

		gohelper.setActive(var_1_40, false)
	end

	if arg_1_3 then
		arg_1_3._scrollbuff.verticalNormalizedPosition = 1

		recthelper.setWidth(arg_1_3._scrollbuff.transform, var_1_6)
	end
end

function var_0_0._setPos(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.viewParam.iconPos
	local var_3_1 = arg_3_0.viewParam.offsetX
	local var_3_2 = arg_3_0.viewParam.offsetY

	arg_3_0.enemyBuffTipPosY = 80

	local var_3_3 = recthelper.rectToRelativeAnchorPos(var_3_0, arg_3_0._gobuffinfocontainer.transform.parent)
	local var_3_4 = recthelper.getWidth(arg_3_0._scrollbuff.transform)
	local var_3_5 = recthelper.getHeight(arg_3_0._scrollbuff.transform)
	local var_3_6 = 0
	local var_3_7 = 0

	if arg_3_1.side == FightEnum.EntitySide.MySide then
		var_3_6 = var_3_3.x - var_3_1
		var_3_7 = var_3_3.y + var_3_2
	else
		var_3_6 = var_3_3.x + var_3_1
		var_3_7 = arg_3_0.enemyBuffTipPosY
	end

	local var_3_8 = UnityEngine.Screen.width * 0.5
	local var_3_9 = 10
	local var_3_10 = {
		min = -var_3_8 + var_3_4 + var_3_9,
		max = var_3_8 - var_3_4 - var_3_9
	}
	local var_3_11 = GameUtil.clamp(var_3_6, var_3_10.min, var_3_10.max)

	recthelper.setAnchor(arg_3_0._gobuffinfocontainer.transform, var_3_11, var_3_7)
end

function var_0_0.onInitView(arg_4_0)
	arg_4_0._gobuffinfocontainer = gohelper.findChild(arg_4_0.viewGO, "root/#go_buffinfocontainer/buff")
	arg_4_0._scrollbuff = gohelper.findChildScrollRect(arg_4_0.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff")
	arg_4_0._gobuffitem = gohelper.findChild(arg_4_0.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content/#go_buffitem")
	arg_4_0._btnclosebuffinfocontainer = gohelper.findChildButton(arg_4_0.viewGO, "root/#go_buffinfocontainer/#btn_click")

	if arg_4_0._editableInitView then
		arg_4_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_5_0)
	arg_5_0._btnclosebuffinfocontainer:AddClickListener(arg_5_0._onCloseBuffInfoContainer, arg_5_0)
end

function var_0_0.removeEvents(arg_6_0)
	arg_6_0._btnclosebuffinfocontainer:RemoveClickListener()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0.rectTrScrollBuff = arg_7_0._scrollbuff:GetComponent(gohelper.Type_RectTransform)
	arg_7_0.rectTrBuffContent = gohelper.findChildComponent(arg_7_0.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content", gohelper.Type_RectTransform)

	gohelper.setActive(arg_7_0._gobuffitem, false)

	arg_7_0._buffItemList = {}
end

function var_0_0._onCloseBuffInfoContainer(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_click)
	arg_8_0:closeThis()
end

function var_0_0.onOpen(arg_9_0)
	gohelper.setActive(gohelper.findChild(arg_9_0.viewGO, "root/tips"), true)

	local var_9_0 = FightDataHelper.entityMgr:getById(arg_9_0.viewParam.entityId or arg_9_0.viewParam)

	arg_9_0:_updateBuffs(var_9_0)

	if arg_9_0.viewParam.viewname and arg_9_0.viewParam.viewname == "FightView" then
		arg_9_0:_setPos(var_9_0)
	else
		local var_9_1 = var_9_0.side == FightEnum.EntitySide.MySide and 207 or -161

		recthelper.setAnchorX(arg_9_0._gobuffinfocontainer.transform, var_9_1)
	end
end

function var_0_0._updateBuffs(arg_10_0, arg_10_1)
	var_0_0._updateBuffDesc_overseas(arg_10_1, arg_10_0._buffItemList, arg_10_0._gobuffitem, arg_10_0, arg_10_0.getCommonBuffTipScrollAnchor)
end

var_0_0.Interval = 10

function var_0_0.getCommonBuffTipScrollAnchor(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = GameUtil.getViewSize() / 2
	local var_11_1 = arg_11_0.rectTrScrollBuff
	local var_11_2 = arg_11_0.rectTrBuffContent
	local var_11_3, var_11_4 = recthelper.uiPosToScreenPos2(var_11_1)
	local var_11_5, var_11_6 = SLFramework.UGUI.RectTrHelper.ScreenPosXYToAnchorPosXY(var_11_3, var_11_4, arg_11_1, CameraMgr.instance:getUICamera(), nil, nil)
	local var_11_7 = recthelper.getWidth(var_11_1) / 2
	local var_11_8 = var_11_0 + var_11_5 - var_11_7 - var_0_0.Interval
	local var_11_9 = recthelper.getWidth(arg_11_2)
	local var_11_10 = var_11_9 <= var_11_8

	arg_11_2.pivot = CommonBuffTipEnum.Pivot.Right

	local var_11_11 = var_11_5
	local var_11_12 = var_11_6

	if var_11_10 then
		var_11_11 = var_11_11 - var_11_7 - var_0_0.Interval
	else
		var_11_11 = var_11_11 + var_11_7 + var_0_0.Interval + var_11_9
	end

	local var_11_13 = math.min(recthelper.getHeight(var_11_1), recthelper.getHeight(var_11_2)) / 2

	recthelper.setAnchor(arg_11_2, var_11_11, var_11_12 + var_11_13)
end

var_0_0.filterTypeKey = {
	[2] = true
}

function var_0_0.updateBuffDesc(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = arg_12_0 and arg_12_0:getBuffList() or {}
	local var_12_1 = tabletool.copy(var_12_0)
	local var_12_2 = FightBuffHelper.filterBuffType(var_12_1, var_0_0.filterTypeKey)

	FightSkillBuffMgr.instance:dealStackerBuff(var_12_2)
	table.sort(var_12_2, function(arg_13_0, arg_13_1)
		if arg_13_0.time ~= arg_13_1.time then
			return arg_13_0.time < arg_13_1.time
		end

		return arg_13_0.id < arg_13_1.id
	end)

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		gohelper.setActive(iter_12_1.go, false)
	end

	local var_12_3 = var_12_2 and #var_12_2 or 0
	local var_12_4 = 0

	for iter_12_2 = 1, var_12_3 do
		local var_12_5 = var_12_2[iter_12_2]
		local var_12_6 = lua_skill_buff.configDict[var_12_5.buffId]

		if var_12_6 and var_12_6.isNoShow == 0 then
			local var_12_7 = lua_skill_bufftype.configDict[var_12_6.typeId]

			var_12_4 = var_12_4 + 1

			local var_12_8 = arg_12_1[var_12_4]

			if not var_12_8 then
				var_12_8 = arg_12_3:getUserDataTb_()
				var_12_8.go = gohelper.cloneInPlace(arg_12_2, "buff" .. var_12_4)
				var_12_8.getAnchorFunc = arg_12_4
				var_12_8.viewClass = arg_12_3

				table.insert(arg_12_1, var_12_8)
			end

			local var_12_9 = var_12_8.go

			gohelper.setActive(var_12_9, true)

			local var_12_10 = gohelper.findChildText(var_12_9, "title/txt_time")

			var_0_0.showBuffTime(var_12_10, var_12_5, var_12_6, arg_12_0)

			local var_12_11 = gohelper.findChildText(var_12_9, "txt_desc")

			SkillHelper.addHyperLinkClick(var_12_11, var_0_0.onClickBuffHyperLink, var_12_8)

			gohelper.findChildText(var_12_9, "title/txt_name").text = var_12_6.name

			local var_12_12 = FightBuffGetDescHelper.getBuffDesc(var_12_5)
			local var_12_13 = GameUtil.getTextHeightByLine(var_12_11, var_12_12, 52.1) + 62

			recthelper.setHeight(var_12_9.transform, var_12_13)

			var_12_11.text = var_12_12

			local var_12_14 = gohelper.findChildImage(var_12_9, "title/simage_icon")

			if var_12_14 then
				UISpriteSetMgr.instance:setBuffSprite(var_12_14, var_12_6.iconId)
			end

			local var_12_15 = gohelper.findChild(var_12_9, "txt_desc/image_line")
			local var_12_16 = gohelper.findChild(var_12_9, "title/txt_name/go_tag")
			local var_12_17 = gohelper.findChildText(var_12_9, "title/txt_name/go_tag/bg/txt_tagname")
			local var_12_18 = lua_skill_buff_desc.configDict[var_12_7.type]

			if var_12_18 then
				var_12_17.text = var_12_18.name
			end

			gohelper.setActive(var_12_16, var_12_18)
			gohelper.setActive(var_12_15, var_12_4 ~= var_12_3)

			arg_12_3._scrollbuff.verticalNormalizedPosition = 1
		end
	end
end

function var_0_0.onClickBuffHyperLink(arg_14_0, arg_14_1, arg_14_2)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPosCallback(arg_14_1, arg_14_0.getAnchorFunc, arg_14_0.viewClass)
end

function var_0_0.showBuffTime(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
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

return var_0_0
