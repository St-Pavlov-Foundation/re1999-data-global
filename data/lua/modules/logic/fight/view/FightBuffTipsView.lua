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

function var_0_0._setPos(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.viewParam.iconPos
	local var_10_1 = arg_10_0.viewParam.offsetX
	local var_10_2 = arg_10_0.viewParam.offsetY

	arg_10_0.enemyBuffTipPosY = 80

	local var_10_3 = recthelper.rectToRelativeAnchorPos(var_10_0, arg_10_0._gobuffinfocontainer.transform.parent)
	local var_10_4 = recthelper.getWidth(arg_10_0.rectTrScrollBuff)
	local var_10_5 = recthelper.getHeight(arg_10_0.rectTrScrollBuff)
	local var_10_6 = 0
	local var_10_7 = 0

	if arg_10_1.side == FightEnum.EntitySide.MySide then
		var_10_6 = var_10_3.x - var_10_1
		var_10_7 = var_10_3.y + var_10_2
	else
		var_10_6 = var_10_3.x + var_10_1
		var_10_7 = arg_10_0.enemyBuffTipPosY
	end

	local var_10_8 = UnityEngine.Screen.width * 0.5
	local var_10_9 = 10
	local var_10_10 = {
		min = -var_10_8 + var_10_4 + var_10_9,
		max = var_10_8 - var_10_4 - var_10_9
	}
	local var_10_11 = GameUtil.clamp(var_10_6, var_10_10.min, var_10_10.max)

	recthelper.setAnchor(arg_10_0._gobuffinfocontainer.transform, var_10_11, var_10_7)
end

function var_0_0._updateBuffs(arg_11_0, arg_11_1)
	arg_11_0:updateBuffDesc(arg_11_1, arg_11_0._buffItemList, arg_11_0._gobuffitem, arg_11_0, arg_11_0.getCommonBuffTipScrollAnchor)
end

var_0_0.Interval = 10

function var_0_0.getCommonBuffTipScrollAnchor(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = GameUtil.getViewSize() / 2
	local var_12_1 = arg_12_0.rectTrScrollBuff
	local var_12_2 = arg_12_0.rectTrBuffContent
	local var_12_3, var_12_4 = recthelper.uiPosToScreenPos2(var_12_1)
	local var_12_5, var_12_6 = SLFramework.UGUI.RectTrHelper.ScreenPosXYToAnchorPosXY(var_12_3, var_12_4, arg_12_1, CameraMgr.instance:getUICamera(), nil, nil)
	local var_12_7 = recthelper.getWidth(var_12_1) / 2
	local var_12_8 = var_12_0 + var_12_5 - var_12_7 - var_0_0.Interval
	local var_12_9 = recthelper.getWidth(arg_12_2)
	local var_12_10 = var_12_9 <= var_12_8

	arg_12_2.pivot = CommonBuffTipEnum.Pivot.Right

	local var_12_11 = var_12_5
	local var_12_12 = var_12_6

	if var_12_10 then
		var_12_11 = var_12_11 - var_12_7 - var_0_0.Interval
	else
		var_12_11 = var_12_11 + var_12_7 + var_0_0.Interval + var_12_9
	end

	local var_12_13 = math.min(recthelper.getHeight(var_12_1), recthelper.getHeight(var_12_2)) / 2

	recthelper.setAnchor(arg_12_2, var_12_11, var_12_12 + var_12_13)
end

var_0_0.filterTypeKey = {
	[2] = true
}

local var_0_5 = 635
local var_0_6 = 597
local var_0_7 = 300

function var_0_0.updateBuffDesc(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	local var_13_0 = arg_13_1 and arg_13_1:getBuffList() or {}
	local var_13_1 = tabletool.copy(var_13_0)
	local var_13_2 = FightBuffHelper.filterBuffType(var_13_1, var_0_0.filterTypeKey)

	FightSkillBuffMgr.instance:dealStackerBuff(var_13_2)
	table.sort(var_13_2, function(arg_14_0, arg_14_1)
		if arg_14_0.time ~= arg_14_1.time then
			return arg_14_0.time < arg_14_1.time
		end

		return arg_14_0.id < arg_14_1.id
	end)

	for iter_13_0, iter_13_1 in ipairs(arg_13_2) do
		gohelper.setActive(iter_13_1.go, false)
	end

	local var_13_3 = var_13_2 and #var_13_2 or 0
	local var_13_4 = 0
	local var_13_5 = -1
	local var_13_6 = var_0_5
	local var_13_7 = var_0_6
	local var_13_8 = {}

	for iter_13_2 = 1, var_13_3 do
		local var_13_9 = var_13_2[iter_13_2]
		local var_13_10 = lua_skill_buff.configDict[var_13_9.buffId]

		if var_13_10 and var_13_10.isNoShow == 0 then
			local var_13_11 = lua_skill_bufftype.configDict[var_13_10.typeId]

			var_13_4 = var_13_4 + 1

			local var_13_12 = arg_13_2[var_13_4]

			if not var_13_12 then
				var_13_12 = arg_13_4:getUserDataTb_()
				var_13_12.go = gohelper.cloneInPlace(arg_13_3, "buff" .. var_13_4)
				var_13_12.getAnchorFunc = arg_13_5
				var_13_12.viewClass = arg_13_4

				table.insert(arg_13_2, var_13_12)
			end

			local var_13_13 = var_13_12.go

			gohelper.setActive(var_13_13, true)

			local var_13_14 = gohelper.findChildText(var_13_13, "title/txt_time")

			var_0_0.showBuffTime(var_13_14, var_13_9, var_13_10, arg_13_1)

			local var_13_15 = gohelper.findChildText(var_13_13, "txt_desc")

			SkillHelper.addHyperLinkClick(var_13_15, var_0_0.onClickBuffHyperLink, var_13_12)

			local var_13_16 = gohelper.findChildText(var_13_13, "title/txt_name")

			var_13_16.text = var_13_10.name

			local var_13_17 = var_13_16.preferredWidth
			local var_13_18 = FightBuffGetDescHelper.getBuffDesc(var_13_9)
			local var_13_19 = GameUtil.getTextHeightByLine(var_13_15, var_13_18, 52.1) + 62

			recthelper.setHeight(var_13_13.transform, var_13_19)

			var_13_15.text = var_13_18

			local var_13_20 = gohelper.findChildImage(var_13_13, "title/simage_icon")

			if var_13_20 then
				UISpriteSetMgr.instance:setBuffSprite(var_13_20, var_13_10.iconId)
			end

			local var_13_21 = gohelper.findChild(var_13_13, "txt_desc/image_line")
			local var_13_22 = gohelper.findChild(var_13_13, "title/txt_name/go_tag")
			local var_13_23 = gohelper.findChildText(var_13_13, "title/txt_name/go_tag/bg/txt_tagname")
			local var_13_24 = lua_skill_buff_desc.configDict[var_13_11.type]

			if var_13_24 then
				var_13_23.text = var_13_24.name
				var_13_17 = var_13_17 + var_13_23.preferredWidth
			end

			gohelper.setActive(var_13_22, var_13_24)
			gohelper.setActive(var_13_21, var_13_4 ~= var_13_3)

			arg_13_4._scrollbuff.verticalNormalizedPosition = 1

			local var_13_25 = var_13_15.transform
			local var_13_26 = gohelper.findChild(var_13_13, "title").transform
			local var_13_27 = var_13_13.transform

			var_13_8[#var_13_8 + 1] = var_13_25
			var_13_8[#var_13_8 + 1] = var_13_26
			var_13_8[#var_13_8 + 1] = var_13_27
			var_13_8[#var_13_8 + 1] = var_13_15
			var_13_8[#var_13_8 + 1] = var_13_9

			if var_13_17 > var_0_7 then
				local var_13_28 = var_13_17 - var_0_7
				local var_13_29 = var_0_6 + var_13_28

				var_13_6 = math.max(var_13_6, var_13_29)
				var_13_7 = math.max(var_13_7, var_13_29)
			end
		end
	end

	recthelper.setWidth(arg_13_0.rectTrScrollBuff, var_13_7)
	recthelper.setWidth(arg_13_0.rectTrBuffContent, var_13_7)

	if #var_13_8 > 0 then
		for iter_13_3 = 0, #var_13_8 - 1, 5 do
			local var_13_30 = var_13_8[iter_13_3 + 1]
			local var_13_31 = var_13_8[iter_13_3 + 2]
			local var_13_32 = var_13_8[iter_13_3 + 3]
			local var_13_33 = var_13_8[iter_13_3 + 4]
			local var_13_34 = var_13_8[iter_13_3 + 5]

			recthelper.setWidth(var_13_31, var_13_7 - 10)
			recthelper.setWidth(var_13_30, var_13_7 - 46)
			ZProj.UGUIHelper.RebuildLayout(var_13_32)
			recthelper.setWidth(var_13_32, var_13_7)

			var_13_33.text = FightBuffGetDescHelper.getBuffDesc(var_13_34)
			var_13_33.text = var_13_33.text

			local var_13_35 = var_13_33.preferredHeight + 52.1 + 10

			recthelper.setHeight(var_13_32, var_13_35)
		end
	end

	for iter_13_4 in pairs(var_13_8) do
		rawset(var_13_8, iter_13_4, nil)
	end

	local var_13_36

	ZProj.UGUIHelper.RebuildLayout(arg_13_0.rectTrBuffContent)
end

function var_0_0.onClickBuffHyperLink(arg_15_0, arg_15_1, arg_15_2)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPosCallback(arg_15_1, arg_15_0.getAnchorFunc, arg_15_0.viewClass)
end

function var_0_0.showBuffTime(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if FightBuffHelper.isCountContinueChanelBuff(arg_16_1) then
		arg_16_0.text = string.format(luaLang("enemytip_buff_time"), arg_16_1.exInfo)

		return
	end

	if arg_16_1 and FightConfig.instance:hasBuffFeature(arg_16_1.buffId, FightEnum.BuffFeature.CountUseSelfSkillContinueChannel) then
		arg_16_0.text = string.format(luaLang("enemytip_buff_time"), arg_16_1.exInfo)

		return
	end

	if FightBuffHelper.isDuduBoneContinueChannelBuff(arg_16_1) then
		arg_16_0.text = string.format(luaLang("buff_tip_duration"), arg_16_1.exInfo)

		return
	end

	if FightBuffHelper.isDeadlyPoisonBuff(arg_16_1) then
		local var_16_0 = FightSkillBuffMgr.instance:getStackedCount(arg_16_1.entityId, arg_16_1)

		arg_16_0.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("buff_tip_round_and_layer"), arg_16_1.duration, var_16_0)

		return
	end

	local var_16_1 = lua_skill_bufftype.configDict[arg_16_2.typeId]
	local var_16_2, var_16_3 = FightSkillBuffMgr.instance:buffIsStackerBuff(arg_16_2)

	if var_16_2 then
		local var_16_4 = string.format(luaLang("enemytip_buff_stacked_count"), FightSkillBuffMgr.instance:getStackedCount(arg_16_3.id, arg_16_1))

		if var_16_3 == FightEnum.BuffIncludeTypes.Stacked12 then
			arg_16_0.text = var_16_4 .. " " .. string.format(luaLang("enemytip_buff_time"), arg_16_1.duration)
		else
			arg_16_0.text = var_16_4
		end
	elseif arg_16_1.duration == 0 then
		if arg_16_1.count == 0 then
			arg_16_0.text = luaLang("forever")
		else
			local var_16_5 = arg_16_1.count
			local var_16_6 = "enemytip_buff_count"
			local var_16_7 = var_16_1 and var_16_1.includeTypes or ""

			if string.split(var_16_7, "#")[1] == "11" then
				var_16_6 = "enemytip_buff_stacked_count"
				var_16_5 = arg_16_1.layer
			end

			arg_16_0.text = string.format(luaLang(var_16_6), var_16_5)
		end
	elseif arg_16_1.count == 0 then
		arg_16_0.text = string.format(luaLang("enemytip_buff_time"), arg_16_1.duration)
	else
		local var_16_8 = arg_16_1.count
		local var_16_9 = "round_or_times"
		local var_16_10 = var_16_1 and var_16_1.includeTypes or ""

		if string.split(var_16_10, "#")[1] == "11" then
			var_16_9 = "round_or_stacked_count"
			var_16_8 = arg_16_1.layer
		end

		local var_16_11 = {
			arg_16_1.duration,
			var_16_8
		}

		arg_16_0.text = GameUtil.getSubPlaceholderLuaLang(luaLang(var_16_9), var_16_11)
	end
end

return var_0_0
