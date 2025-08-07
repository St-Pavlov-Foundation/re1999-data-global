module("modules.logic.sp01.odyssey.view.OdysseyEquipItem", package.seeall)

local var_0_0 = class("OdysseyEquipItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageRare = gohelper.findChildImage(arg_1_0.viewGO, "rare")
	arg_1_0._simageIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "icon")
	arg_1_0._goCount = gohelper.findChild(arg_1_0.viewGO, "countbg")
	arg_1_0._txtCount = gohelper.findChildText(arg_1_0.viewGO, "count")
	arg_1_0._goSuit = gohelper.findChild(arg_1_0.viewGO, "suit")
	arg_1_0._imageSuit = gohelper.findChildImage(arg_1_0.viewGO, "suit/image_suitIcon")
	arg_1_0._goHero = gohelper.findChild(arg_1_0.viewGO, "hero")
	arg_1_0._simageHeroIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "hero/simage_heroIcon")
	arg_1_0._btnClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "click")
	arg_1_0._goSelect = gohelper.findChild(arg_1_0.viewGO, "go_select")
	arg_1_0._goReddot = gohelper.findChild(arg_1_0.viewGO, "go_reddot")
	arg_1_0._goExpIcon = gohelper.findChild(arg_1_0.viewGO, "expIcon")
	arg_1_0._goTalentIcon = gohelper.findChild(arg_1_0.viewGO, "talentIcon")
	arg_1_0.fontSize = arg_1_0._txtCount.fontSize
	arg_1_0.countBgScale = transformhelper.getLocalScale(arg_1_0._goCount.transform)
	arg_1_0._goUnknowSuitIcon = gohelper.findChild(arg_1_0.viewGO, "unknowSuitIcon")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._enableDeselect = true

	arg_2_0:hideIcon()
end

function var_0_0.hideIcon(arg_3_0)
	gohelper.setActive(arg_3_0._goSuit, false)
	gohelper.setActive(arg_3_0._goHero, false)
	gohelper.setActive(arg_3_0._goExpIcon, false)
	gohelper.setActive(arg_3_0._goTalentIcon, false)
	gohelper.setActive(arg_3_0._goUnknowSuitIcon, false)
end

function var_0_0.addEvents(arg_4_0)
	arg_4_0._btnClick:AddClickListener(arg_4_0.onClick, arg_4_0)
end

function var_0_0.removeEvents(arg_5_0)
	arg_5_0._btnClick:RemoveClickListener()
end

function var_0_0.onSelect(arg_6_0, arg_6_1)
	arg_6_0._isSelect = arg_6_1

	gohelper.setActive(arg_6_0._goSelect, arg_6_1)

	if arg_6_0._isSelect then
		OdysseyItemModel.instance:setHasClickItem(arg_6_0.mo.uid)
		gohelper.setActive(arg_6_0._goReddot, false)
		OdysseyController.instance:dispatchEvent(OdysseyEvent.OnRefreshBagReddot)
	end
end

function var_0_0.onClick(arg_7_0)
	logNormal("奥德赛道具点击 id: " .. tostring(arg_7_0.itemId) .. "uid : " .. tostring(arg_7_0.mo.uid))

	if arg_7_0.itemConfig.type == OdysseyEnum.ItemType.Item and OdysseyItemModel.instance:getItemCount(arg_7_0.itemId) > 0 == false then
		logNormal("奥德赛 任务道具数量不足")

		return
	end

	local var_7_0 = arg_7_0._isSelect and arg_7_0._enableDeselect

	if var_7_0 and arg_7_0.bagType == OdysseyEnum.BagType.Bag then
		return
	end

	if var_7_0 then
		arg_7_0._view:selectCell(arg_7_0._index, false)
	else
		arg_7_0._view:selectCell(arg_7_0._index, true)
	end

	OdysseyItemModel.instance:setHasClickItem(arg_7_0.mo.uid)
	OdysseyController.instance:dispatchEvent(OdysseyEvent.OnEquipItemSelect, not var_7_0 and arg_7_0.mo or nil)
	gohelper.setActive(arg_7_0._goReddot, false)
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0.mo = arg_8_1
	arg_8_0.bagType = arg_8_1.type

	local var_8_0 = arg_8_1.itemMo

	arg_8_0.itemId = var_8_0.id
	arg_8_0.itemConfig = var_8_0.config
	arg_8_0.isNewFlag = var_8_0:isNew()

	arg_8_0:initItemInfo()
end

function var_0_0.initItemInfo(arg_9_0)
	gohelper.setActive(arg_9_0._goSuit, arg_9_0.itemType == OdysseyEnum.ItemType.Equip and arg_9_0.itemConfig and arg_9_0.itemConfig.suitId > 0)

	if arg_9_0.itemConfig.type == OdysseyEnum.ItemType.Item then
		local var_9_0 = OdysseyItemModel.instance:getItemCount(arg_9_0.itemId) > 0

		gohelper.setActive(arg_9_0._simageIcon, var_9_0)
		gohelper.setActive(arg_9_0._goUnknowSuitIcon, not var_9_0)

		if var_9_0 then
			arg_9_0._simageIcon:LoadImage(ResUrl.getSp01OdysseyItemSingleBg(arg_9_0.itemConfig.icon))
		end
	elseif arg_9_0.itemConfig.type == OdysseyEnum.ItemType.Equip then
		gohelper.setActive(arg_9_0._simageIcon, true)
		arg_9_0._simageIcon:LoadImage(ResUrl.getSp01OdysseyItemSingleBg(arg_9_0.itemConfig.icon))
	end

	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(arg_9_0._imageRare, "odyssey_item_quality" .. arg_9_0.itemConfig.rare)

	local var_9_1 = OdysseyItemModel.instance:isHasClickItem(arg_9_0.mo.uid)

	gohelper.setActive(arg_9_0._goReddot, not var_9_1 and arg_9_0.isNewFlag)
	arg_9_0:setShowCountState(false)
	arg_9_0:refreshItemEquipState()
	arg_9_0:refreshEquipSuitState()
	arg_9_0:setFontScale()
end

function var_0_0.refreshItemEquipState(arg_10_0)
	local var_10_0 = arg_10_0.bagType == OdysseyEnum.BagType.FightPrepare and arg_10_0.itemConfig.type == OdysseyEnum.ItemType.Equip
	local var_10_1 = false

	if var_10_0 then
		local var_10_2 = OdysseyHeroGroupModel.instance:getCurHeroGroup().odysseyEquipDic[arg_10_0.mo.uid]

		if var_10_2 then
			local var_10_3 = var_10_2.heroId

			if var_10_3 ~= 0 then
				local var_10_4

				if var_10_3 < 0 then
					local var_10_5 = lua_hero_trial.configDict[-var_10_3][0]

					var_10_4 = SkinConfig.instance:getSkinCo(var_10_5.skin)
				else
					local var_10_6 = HeroModel.instance:getByHeroId(var_10_3)

					var_10_4 = SkinConfig.instance:getSkinCo(var_10_6.skin)
				end

				if var_10_4 == nil then
					logError("奥德赛角色活动 角色皮肤表id为空：装备uid：" .. tostring(arg_10_0.mo.uid))
				else
					var_10_1 = true

					local var_10_7 = ResUrl.getRoomHeadIcon(var_10_4.headIcon)

					arg_10_0._simageHeroIcon:LoadImage(var_10_7)
				end
			end
		end
	end

	gohelper.setActive(arg_10_0._goHero, var_10_0 and var_10_1)
end

function var_0_0.refreshEquipSuitState(arg_11_0)
	local var_11_0 = arg_11_0.itemConfig.type == OdysseyEnum.ItemType.Equip

	gohelper.setActive(arg_11_0._goSuit, var_11_0)

	if var_11_0 then
		local var_11_1 = OdysseyConfig.instance:getEquipSuitConfig(arg_11_0.itemConfig.suitId)

		UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(arg_11_0._imageSuit, var_11_1.icon)
	end
end

function var_0_0.setFontScale(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.viewGO.transform.parent
	local var_12_1 = var_12_0 and transformhelper.getLocalScale(var_12_0) or 1

	transformhelper.setLocalScale(arg_12_0._goCount.transform, arg_12_0.countBgScale, arg_12_1 or arg_12_0.countBgScale / var_12_1, arg_12_0.countBgScale)

	arg_12_0._txtCount.fontSize = arg_12_0.fontSize * (arg_12_1 or 1 / var_12_1)
end

function var_0_0.setShowCountState(arg_13_0, arg_13_1)
	gohelper.setActive(arg_13_0._goCount, arg_13_1)
	gohelper.setActive(arg_13_0._txtCount, arg_13_1)
end

return var_0_0
