module("modules.logic.equip.controller.EquipHelper", package.seeall)

return {
	sortType = {
		sortLvDown = "sortLvDown",
		sortQualityDown = "sortQualityDown",
		sortQualityUp = "sortQualityUp",
		sortLvUp = "sortLvUp"
	},
	equipSkillAddHighAttr = {
		"cri",
		"recri",
		"criDmg",
		"criDef",
		"addDmg",
		"dropDmg",
		"revive",
		"absorb",
		"clutch",
		"heal",
		"defenseIgnore"
	},
	equipSkillAddHighAttrSortPriority = {
		absorb = 5,
		cri = 2,
		defenseIgnore = 4,
		dropDmg = 8,
		revive = 9,
		recri = 10,
		addDmg = 1,
		criDmg = 3,
		heal = 7,
		criDef = 11,
		clutch = 6
	},
	CareerValue = {
		All = "0",
		Wisdom = "6",
		Animal = "4",
		Star = "2",
		Rock = "1",
		Spirit = "5",
		Wood = "3",
		SAW = "5_6"
	},
	EquipSkillColor = {
		["0"] = "#FFFFFF",
		["1"] = "#8C6838",
		["5|6"] = "#765A79",
		["2"] = "#4C7199",
		["3"] = "#3F8C52",
		["4"] = "#B35959"
	},
	DefaultEquipSkillColorIndex = "0",
	getEquipSkillDes = function (slot0, slot1, slot2, slot3)
		if not EquipConfig.instance:getEquipSkillCfg(EquipConfig.instance:getEquipCo(slot0).skillType, slot1) then
			return ""
		end

		slot7 = uv0.calEquipSkillBaseDes(slot5.baseDesc)

		if not string.nilorempty(uv0.getEquipSkillAdvanceAttrDes(slot0, slot1, slot3)) and not string.nilorempty(slot7) then
			slot7 = "，" .. slot7
		end

		if not string.nilorempty(slot5.spDesc) then
			slot6 = slot6 .. slot7 .. "\n" .. uv0.getSpecialSkillDes(slot0, slot1)
		end

		if slot2 then
			slot6 = HeroSkillModel.instance:skillDesToSpot(slot6, nil, , true)
		end

		return slot6
	end,
	calEquipSkillBaseDes = function (slot0, slot1)
		return string.gsub(string.gsub(slot0, "%{", string.format("<color=%s>", slot1 or "#C66030")), "%}", "</color>")
	end,
	getEquipSkillAdvanceAttrDes = function (slot0, slot1, slot2)
		if not EquipConfig.instance:getEquipSkillCfg(EquipConfig.instance:getEquipCo(slot0).skillType, slot1) then
			return ""
		end

		slot6 = nil

		for slot10, slot11 in ipairs(uv0.equipSkillAddHighAttr) do
			if (slot4[slot11] or 0) ~= 0 then
				slot5 = "" .. HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(slot11)).name .. luaLang("equip_skill_upgrade") .. slot12 / 10 .. "%，"
			end
		end

		if not string.nilorempty(slot5) then
			slot5 = luaLang("equip_refine_memory") .. slot5
			slot5 = string.sub(slot5, 1, #slot5 - GameUtil.charsize(string.byte("，")))
		end

		if slot2 then
			slot5 = HeroSkillModel.instance:skillDesToSpot(slot5, nil, , true)
		end

		return slot5
	end,
	getEquipSkillAdvanceAttrDesTab = function (slot0, slot1, slot2)
		if not EquipConfig.instance:getEquipSkillCfg(EquipConfig.instance:getEquipCo(slot0).skillType, slot1) then
			logError(string.format("not found equipSKill config, equipId : %s, equip SkillType : %s, refine level : %s", slot0, slot3.skillType, slot1))

			return nil
		end

		slot5 = {}
		slot6, slot7, slot8 = nil

		for slot12, slot13 in ipairs(uv0.equipSkillAddHighAttr) do
			if (slot4[slot13] or 0) ~= 0 then
				slot6 = {}

				if slot2 then
					slot8 = HeroSkillModel.instance:skillDesToSpot(HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(slot13)).name .. luaLang("equip_skill_upgrade") .. "<space=0.45em>" .. slot14 / 10 .. "%", slot2, nil, true)
				end

				slot6.desc = slot8
				slot6.key = slot13
				slot6.value = slot14

				table.insert(slot5, slot6)
			end
		end

		table.sort(slot5, function (slot0, slot1)
			if slot0.value ~= slot1.value then
				return slot1.value < slot0.value
			end

			return uv0.equipSkillAddHighAttrSortPriority[slot0.key] < uv0.equipSkillAddHighAttrSortPriority[slot1.key]
		end)

		slot9 = {}

		for slot13 = 1, #slot5 do
			table.insert(slot9, slot5[slot13].desc)
		end

		return slot9
	end,
	getEquipSkillBaseDes = function (slot0, slot1, slot2)
		if not EquipConfig.instance:getEquipSkillCfg(EquipConfig.instance:getEquipCo(slot0).skillType, slot1) then
			return ""
		end

		slot5 = {}

		if not string.nilorempty(slot4.baseDesc) then
			table.insert(slot5, uv0.calEquipSkillBaseDes(slot4.baseDesc, slot2))
		end

		return slot5
	end,
	getEquipSkillDescList = function (slot0, slot1, slot2)
		slot5 = {}

		if not EquipConfig.instance:getEquipSkillCfg(EquipConfig.instance:getEquipCo(slot0).skillType, slot1) then
			return {}
		end

		if not string.nilorempty(slot4.baseDesc) then
			table.insert(slot5, uv0.calEquipSkillBaseDes(slot4.baseDesc, slot2))
		end

		return slot5
	end,
	getSpecialSkillDes = function (slot0, slot1)
		if not EquipConfig.instance:getEquipSkillCfg(EquipConfig.instance:getEquipCo(slot0).skillType, slot1) or string.nilorempty(slot3.spDesc) then
			return ""
		end

		return string.format("<#4b93d6><u><link='%s'>[%s]:</link></u></color>", slot0, slot2.feature) .. slot3.spDesc, slot2.feature, slot3.spDesc
	end,
	isRefineUniversalMaterials = function (slot0)
		return slot0 == EquipConfig.instance:getEquipUniversalId()
	end,
	isExpEquip = function (slot0)
		return slot0 and slot0.isExpEquip == 1
	end,
	isConsumableEquip = function (slot0)
		return uv0.isRefineUniversalMaterials(slot0) or uv0.isExpEquip(EquipConfig.instance:getEquipCo(slot0))
	end,
	isSpRefineEquip = function (slot0)
		return slot0 and slot0.isSpRefine ~= 0
	end,
	isNormalEquip = function (slot0)
		return slot0 and not uv0.isExpEquip(slot0) and not uv0.isRefineUniversalMaterials(slot0.id) and not uv0.isSpRefineEquip(slot0)
	end,
	sortLvUp = function (slot0, slot1)
		if slot0.level == slot1.level then
			if slot0.config.rare == slot1.config.rare then
				return slot1.id < slot0.id
			else
				return slot1.config.rare < slot0.config.rare
			end
		else
			return slot1.level < slot0.level
		end
	end,
	sortLvDown = function (slot0, slot1)
		if slot0.level == slot1.level then
			if slot0.config.rare == slot1.config.rare then
				return slot1.id < slot0.id
			else
				return slot1.config.rare < slot0.config.rare
			end
		else
			return slot0.level < slot1.level
		end
	end,
	sortQualityUp = function (slot0, slot1)
		if slot0.config.rare == slot1.config.rare then
			if slot0.level == slot1.level then
				return slot1.id < slot0.id
			else
				return slot1.level < slot0.level
			end
		else
			return slot1.config.rare < slot0.config.rare
		end
	end,
	sortQualityDown = function (slot0, slot1)
		if slot0.config.rare == slot1.config.rare then
			if slot0.level == slot1.level then
				return slot1.id < slot0.id
			else
				return slot1.level < slot0.level
			end
		else
			return slot0.config.rare < slot1.config.rare
		end
	end,
	typeSort = function (slot0, slot1, slot2)
		slot3 = nil
		slot4 = true

		if uv0.isRefineUniversalMaterials(slot0.id) ~= uv0.isRefineUniversalMaterials(slot1.id) then
			if uv0.isRefineUniversalMaterials(slot0.id) then
				slot3 = true
			else
				slot3 = false
			end
		elseif uv0.isSpRefineEquip(slot0) ~= uv0.isSpRefineEquip(slot1) then
			if uv0.isSpRefineEquip(slot0) then
				slot3 = true
			else
				slot3 = false
			end
		elseif uv0.isNormalEquip(slot0) ~= uv0.isNormalEquip(slot1) then
			if uv0.isNormalEquip(slot0) then
				slot3 = true
			else
				slot3 = false
			end
		else
			slot4 = false
		end

		if slot2 then
			return not slot3, slot4
		else
			return slot3, slot4
		end
	end,
	sortRefineList = function (slot0, slot1)
		slot4, slot5 = uv0.typeSort(slot0.config, slot1.config)

		if slot5 then
			return slot4
		end

		if slot0.refineLv ~= slot1.refineLv then
			return slot0.refineLv < slot1.refineLv
		else
			return slot0.level < slot1.level
		end

		return false
	end,
	createMaxLevelEquipMo = function (slot0, slot1)
		slot2 = EquipConfig.instance:getEquipCo(slot0)
		slot3 = uv0.isNormalEquip(slot2)
		slot4 = EquipMO.New()
		slot4.config = slot2
		slot4.equipId = slot2.id

		if slot1 then
			slot4.id = slot1
		end

		if slot3 then
			slot4.level = EquipConfig.instance:getMaxLevel(slot2)
			slot4.refineLv = EquipConfig.instance:getEquipRefineLvMax()
			slot4.breakLv = EquipConfig.instance:getEquipMaxBreakLv(slot2.rare)
		else
			slot4.level = 1
			slot4.refineLv = 1
			slot4.breakLv = 1
		end

		return slot4
	end,
	createMinLevelEquipMo = function (slot0, slot1)
		slot2 = EquipConfig.instance:getEquipCo(slot0)
		slot3 = EquipMO.New()
		slot3.config = slot2
		slot3.equipId = slot2.id

		if slot1 then
			slot3.id = slot1
		end

		slot3.level = 1
		slot3.refineLv = 1
		slot3.breakLv = 0

		return slot3
	end,
	sortByLevelFunc = function (slot0, slot1)
		slot4, slot5 = uv0.typeSort(slot0.config, slot1.config)

		if slot5 then
			return slot4
		end

		if slot0.level ~= slot1.level then
			if CharacterBackpackEquipListModel.instance._levelAscend then
				return slot0.level < slot1.level
			else
				return slot1.level < slot0.level
			end
		elseif slot0.config.rare ~= slot1.config.rare then
			return slot1.config.rare < slot0.config.rare
		elseif slot0.equipId ~= slot1.equipId then
			return slot1.equipId < slot0.equipId
		elseif slot0.config.rare == slot1.config.rare then
			if slot0.refineLv ~= slot1.refineLv then
				return slot1.refineLv < slot0.refineLv
			else
				return slot0.uid < slot1.uid
			end
		else
			return slot0.uid < slot1.uid
		end
	end,
	sortByLevelFuncChooseListModel = function (slot0, slot1)
		if uv0.isNormalEquip(slot0.config) ~= uv0.isNormalEquip(slot1.config) then
			if uv0.isNormalEquip(slot0.config) then
				return false
			else
				return true
			end
		elseif slot0.level ~= slot1.level then
			if EquipChooseListModel.instance._levelAscend then
				return slot0.level < slot1.level
			else
				return slot1.level < slot0.level
			end
		elseif slot0.config.rare ~= slot1.config.rare then
			if EquipChooseListModel.instance._qualityAscend then
				return slot0.config.rare < slot1.config.rare
			else
				return slot1.config.rare < slot0.config.rare
			end

			return slot1.config.rare < slot0.config.rare
		elseif slot0.equipId ~= slot1.equipId then
			return slot1.equipId < slot0.equipId
		elseif slot0.config.rare == slot1.config.rare then
			if slot0.refineLv ~= slot1.refineLv then
				return slot1.refineLv < slot0.refineLv
			else
				return slot0.uid < slot1.uid
			end
		else
			return slot0.uid < slot1.uid
		end
	end,
	sortByQualityFunc = function (slot0, slot1)
		slot4, slot5 = uv0.typeSort(slot0.config, slot1.config)

		if slot5 then
			return slot4
		end

		if slot0.config.rare ~= slot1.config.rare then
			if CharacterBackpackEquipListModel.instance._qualityAscend then
				return slot0.config.rare < slot1.config.rare
			else
				return slot1.config.rare < slot0.config.rare
			end
		elseif slot0.level ~= slot1.level then
			return slot1.level < slot0.level
		elseif slot0.equipId ~= slot1.equipId then
			return slot1.equipId < slot0.equipId
		elseif slot0.level == slot1.level then
			return slot0.uid < slot1.uid
		else
			return slot0.uid < slot1.uid
		end
	end,
	sortByQualityFuncChooseListModel = function (slot0, slot1)
		if uv0.isNormalEquip(slot0.config) ~= uv0.isNormalEquip(slot1.config) then
			if uv0.isNormalEquip(slot0.config) then
				return false
			else
				return true
			end
		elseif slot0.config.rare ~= slot1.config.rare then
			if EquipChooseListModel.instance._qualityAscend then
				return slot0.config.rare < slot1.config.rare
			else
				return slot1.config.rare < slot0.config.rare
			end
		elseif slot0.level ~= slot1.level then
			if EquipChooseListModel.instance._levelAscend then
				return slot0.level < slot1.level
			else
				return slot1.level < slot0.level
			end
		elseif slot0.equipId ~= slot1.equipId then
			return slot1.equipId < slot0.equipId
		elseif slot0.level == slot1.level then
			return slot0.uid < slot1.uid
		else
			return slot0.uid < slot1.uid
		end
	end,
	sortByTimeFunc = function (slot0, slot1)
		slot4, slot5 = uv0.typeSort(slot0.config, slot1.config)

		if slot5 then
			return slot4
		end

		if slot0.id ~= slot1.id then
			if CharacterBackpackEquipListModel.instance._timeAscend then
				return slot0.id < slot1.id
			else
				return slot1.id < slot0.id
			end
		elseif slot0.level ~= slot1.level then
			return slot1.level < slot0.level
		else
			return slot1.config.rare < slot0.config.rare
		end
	end,
	detectEquipSkillSuited = function (slot0, slot1, slot2)
		slot4 = EquipConfig.instance:getEquipSkillCfg(slot1, slot2)

		if not HeroConfig.instance:getHeroCO(slot0) then
			return false
		end

		if not slot4 then
			logError("装备技能表找不到id：", slot1, "Lv:", slot2)

			return
		end

		if #(string.splitToNumber(slot4.career, "|") or {}) == 0 then
			return true
		end

		for slot9, slot10 in ipairs(slot5) do
			if slot10 == slot3.career then
				return true
			end
		end

		return false
	end,
	getEquipSkillCareer = function (slot0, slot1)
		return nil
	end,
	isEqualCareer = function (slot0, slot1)
		if slot1 == uv0.CareerValue.All then
			return true
		end

		slot3 = string.splitToNumber(uv0.getEquipSkillCareer(slot0.config.id, slot0.refineLv), "|")

		for slot8, slot9 in ipairs(string.splitToNumber(slot1, "_")) do
			for slot13, slot14 in ipairs(slot3) do
				if slot14 == slot9 then
					return true
				end
			end
		end

		return false
	end,
	isEqualCareerByCo = function (slot0, slot1)
		if slot1 == uv0.CareerValue.All then
			return true
		end

		slot3 = string.splitToNumber(uv0.getEquipSkillCareer(slot0.id, 1), "|")

		for slot8, slot9 in ipairs(string.splitToNumber(slot1, "_")) do
			for slot13, slot14 in ipairs(slot3) do
				if slot14 == slot9 then
					return true
				end
			end
		end

		return false
	end,
	getSkillBaseDescAndIcon = function (slot0, slot1, slot2)
		slot3 = uv0.getEquipSkillCareer(slot0, slot1)

		return uv0.getEquipSkillBaseDes(slot0, slot1, slot2), uv0.getSkillCarrerIconName(slot3), uv0.getSkillBaseNameColor(slot3)
	end,
	getSkillCarrerIconName = function (slot0)
		slot1 = "bg_shuxing"

		if string.nilorempty(slot0) then
			slot1 = "bg_shuxing_0"
		else
			for slot6, slot7 in ipairs(string.splitToNumber(slot0, "|")) do
				slot1 = slot1 .. "_" .. slot7
			end
		end

		return slot1
	end,
	getSkillCarrerSpecialIconName = function (slot0)
		slot1 = nil

		if string.nilorempty(slot0) then
			slot1 = "lssx_0"
		else
			for slot6, slot7 in ipairs(string.splitToNumber(slot0, "|")) do
				slot1 = "jinglian" .. "_" .. slot7
			end
		end

		return slot1
	end,
	getSkillCareerNewIconName = function (slot0, slot1)
		if string.nilorempty(slot0) then
			slot1 = slot1 and slot1 .. "_0" or "lssx_0"
		else
			for slot6, slot7 in ipairs(string.splitToNumber(slot0, "|")) do
				slot1 = (slot1 or "career") .. "_" .. slot7
			end
		end

		return slot1
	end,
	loadEquipCareerNewIcon = function (slot0, slot1, slot2, slot3)
		if not string.nilorempty(uv0.getEquipSkillCareer(slot0.id, slot2 or 1)) and uv0.isHasSkillBaseDesc(slot0.id, slot2 or 1) then
			UISpriteSetMgr.instance:setCommonSprite(slot1, uv0.getSkillCareerNewIconName(slot4, slot3))
			gohelper.setActive(slot1.gameObject, true)
		else
			gohelper.setActive(slot1.gameObject, false)
		end
	end,
	isHasSkillBaseDesc = function (slot0, slot1)
		if not EquipConfig.instance:getEquipSkillCfg(EquipConfig.instance:getEquipCo(slot0).skillType, slot1) or string.nilorempty(slot3.baseDesc) then
			return false
		end

		return true
	end,
	getSkillBaseNameColor = function (slot0)
		return uv0.EquipSkillColor[uv0.DefaultEquipSkillColorIndex]
	end,
	getDefaultColor = function ()
		return uv0.EquipSkillColor[uv0.DefaultEquipSkillColorIndex]
	end,
	getEquipIconLoadPath = function (slot0)
		slot2 = slot0._config.icon

		slot0._simageicon:LoadImage(slot0.isExpEquip and ResUrl.getEquipIcon(string.format("%s_equip", slot2)) or ResUrl.getEquipIcon(slot2), slot0._loadImageFinish, slot0)
	end,
	getEquipDefaultIconLoadPath = function (slot0)
		slot0._simageicon:LoadImage(ResUrl.getHeroDefaultEquipIcon(slot0._config.icon), uv0.getEquipDefaultIconLoadEnd, slot0)
	end,
	getEquipDefaultIconLoadEnd = function (slot0)
		slot0._simageicon:GetComponent(gohelper.Type_Image):SetNativeSize()
		slot0:_loadImageFinish()
	end,
	getAttrPercentValueStr = function (slot0)
		return GameUtil.noMoreThanOneDecimalPlace(slot0 / 10) .. "%"
	end,
	getAttrBreakText = function (slot0)
		return HeroConfig.instance:getHeroAttributeCO(slot0).name
	end,
	getEquipSkillDesc = function (slot0)
		return SkillHelper.addBracketColor(SkillHelper.addLink(slot0))
	end
}
