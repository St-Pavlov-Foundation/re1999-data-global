module("modules.logic.season.view1_3.Season1_3FightCardItem", package.seeall)

local var_0_0 = class("Season1_3FightCardItem", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.goTop = gohelper.findChild(arg_1_1, "go_top")
	arg_1_0.imageHead = gohelper.findChildImage(arg_1_1, "go_top/headiconbg/image_headicon")
	arg_1_0.txtName = gohelper.findChildTextMesh(arg_1_1, "go_top/headiconbg/txt_owner")
	arg_1_0.goSpecialCardBg = gohelper.findChild(arg_1_1, "bottom/left/go_specialcardbg")
	arg_1_0.goCardPos = gohelper.findChild(arg_1_1, "bottom/left/go_cardpos")
	arg_1_0.goSpecialCardName = gohelper.findChild(arg_1_1, "bottom/right/righttop/go_special")
	arg_1_0.txtSpecialCardName = gohelper.findChildTextMesh(arg_1_0.goSpecialCardName, "txt_specialcardname")
	arg_1_0.goNormalName = gohelper.findChild(arg_1_1, "bottom/right/righttop/go_normal")
	arg_1_0.txtNormalCardName = gohelper.findChildTextMesh(arg_1_0.goNormalName, "txt_normalcardname")
	arg_1_0._goDesc = gohelper.findChild(arg_1_1, "bottom/right/desclist/txt_descitem")
	arg_1_0.layoutElement = gohelper.findChild(arg_1_1, "bottom"):GetComponent(typeof(UnityEngine.UI.LayoutElement))
end

var_0_0.MainRoleItemMinHeight = 390
var_0_0.NormalRoleItemMinHeight = 315
var_0_0.RoleCardPos = {
	Vector2(-16.5, 0.5),
	Vector2(-16.5, 0.5),
	Vector2(-16.5, -6.5),
	Vector2(-16.5, -17),
	Vector2(-16.5, -1)
}

function var_0_0.setData(arg_2_0, arg_2_1)
	if not arg_2_1 then
		gohelper.setActive(arg_2_0.go, false)

		return
	end

	gohelper.setActive(arg_2_0.go, true)

	arg_2_0.trialId = arg_2_1.trialId
	arg_2_0.equipId = arg_2_1.equipId
	arg_2_0.heroUid = arg_2_1.heroUid
	arg_2_0.isMainRole = not arg_2_0.heroUid or arg_2_0.heroUid == "-100000"

	gohelper.setActive(arg_2_0.goSpecialCardBg, arg_2_0.isMainRole)

	arg_2_0.layoutElement.minHeight = arg_2_0.isMainRole and var_0_0.MainRoleItemMinHeight or var_0_0.NormalRoleItemMinHeight

	gohelper.setActive(arg_2_0.goTop, arg_2_1.count == 1)
	arg_2_0:_setName()
	arg_2_0:_setHead()
	arg_2_0:_setCard(arg_2_0.equipId)
	arg_2_0:_setDesc(arg_2_0.equipId)
end

function var_0_0._setName(arg_3_0)
	if arg_3_0.isMainRole then
		arg_3_0.txtName.text = luaLang("seasonmainrolecardname")
	else
		local var_3_0 = HeroModel.instance:getById(arg_3_0.heroUid) or HeroGroupTrialModel.instance:getById(arg_3_0.heroUid)
		local var_3_1 = var_3_0 and var_3_0.config and var_3_0.config.name or ""

		if arg_3_0.trialId then
			local var_3_2 = lua_hero_trial.configDict[arg_3_0.trialId] and lua_hero_trial.configDict[arg_3_0.trialId][0]

			if var_3_2 then
				var_3_1 = HeroConfig.instance:getHeroCO(var_3_2.heroId).name or ""
			end
		end

		arg_3_0.txtName.text = formatLuaLang("seasoncardnames", var_3_1)
	end
end

function var_0_0._setHead(arg_4_0)
	local var_4_0 = Activity104Enum.MainRoleHeadIconID

	if not arg_4_0.isMainRole then
		local var_4_1 = HeroModel.instance:getById(arg_4_0.heroUid) or HeroGroupTrialModel.instance:getById(arg_4_0.heroUid)

		if var_4_1 and var_4_1.skin then
			local var_4_2 = SkinConfig.instance:getSkinCo(var_4_1.skin)

			var_4_0 = var_4_2 and var_4_2.headIcon
		end

		if arg_4_0.trialId then
			local var_4_3 = lua_hero_trial.configDict[arg_4_0.trialId] and lua_hero_trial.configDict[arg_4_0.trialId][0]

			if var_4_3 then
				local var_4_4 = HeroConfig.instance:getHeroCO(var_4_3.heroId)
				local var_4_5

				if var_4_3.skin > 0 then
					var_4_5 = SkinConfig.instance:getSkinCo(var_4_3.skin)
				else
					var_4_5 = SkinConfig.instance:getSkinCo(var_4_4.skinId)
				end

				var_4_0 = var_4_5 and var_4_5.headIcon
			end
		end
	end

	gohelper.getSingleImage(arg_4_0.imageHead.gameObject):LoadImage(ResUrl.roomHeadIcon(var_4_0))
end

function var_0_0._setCard(arg_5_0, arg_5_1)
	if not arg_5_0.cardItem then
		arg_5_0.cardItem = Season1_3CelebrityCardItem.New()

		arg_5_0.cardItem:init(arg_5_0.goCardPos, arg_5_1, {
			noClick = true
		})
	else
		arg_5_0.cardItem:reset(arg_5_1)
	end

	local var_5_0 = SeasonConfig.instance:getSeasonEquipCo(arg_5_1).rare
	local var_5_1 = var_0_0.RoleCardPos[tonumber(var_5_0)] or Vector2(0, 0)

	recthelper.setAnchor(arg_5_0.goCardPos.transform, var_5_1.x, var_5_1.y)
end

function var_0_0._setDesc(arg_6_0, arg_6_1)
	local var_6_0 = SeasonConfig.instance:getSeasonEquipCo(arg_6_1)

	if arg_6_0.isMainRole then
		gohelper.setActive(arg_6_0.goSpecialCardName, true)
		gohelper.setActive(arg_6_0.goNormalName, false)

		arg_6_0.txtSpecialCardName.text = var_6_0.name
	else
		gohelper.setActive(arg_6_0.goNormalName, true)
		gohelper.setActive(arg_6_0.goSpecialCardName, false)

		arg_6_0.txtNormalCardName.text = var_6_0.name
	end

	local var_6_1 = SeasonEquipMetaUtils.getSkillEffectStrList(var_6_0)
	local var_6_2 = SeasonEquipMetaUtils.getEquipPropsStrList(var_6_0.attrId)
	local var_6_3 = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_2) do
		table.insert(var_6_3, iter_6_1)
	end

	for iter_6_2, iter_6_3 in ipairs(var_6_1) do
		table.insert(var_6_3, iter_6_3)
	end

	if not arg_6_0.itemList then
		arg_6_0.itemList = arg_6_0:getUserDataTb_()
	end

	for iter_6_4 = 1, math.max(#arg_6_0.itemList, #var_6_3) do
		local var_6_4 = var_6_3[iter_6_4]
		local var_6_5 = arg_6_0.itemList[iter_6_4] or arg_6_0:createDescItem(iter_6_4)

		arg_6_0:updateDescItem(var_6_5, var_6_4)
	end
end

function var_0_0.createDescItem(arg_7_0, arg_7_1)
	local var_7_0 = {}
	local var_7_1 = gohelper.cloneInPlace(arg_7_0._goDesc, string.format("desc%s", arg_7_1))

	var_7_0.go = var_7_1
	var_7_0.txtDesc = var_7_1:GetComponent(typeof(TMPro.TMP_Text))
	arg_7_0.itemList[arg_7_1] = var_7_0

	return var_7_0
end

function var_0_0.updateDescItem(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_2 then
		gohelper.setActive(arg_8_1.go, false)

		return
	end

	gohelper.setActive(arg_8_1.go, true)

	arg_8_1.txtDesc.text = arg_8_2 or ""
end

function var_0_0.destroyDescItem(arg_9_0, arg_9_1)
	return
end

function var_0_0.destroy(arg_10_0)
	if arg_10_0.itemList then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0.itemList) do
			arg_10_0:destroyDescItem(iter_10_1)
		end

		arg_10_0.itemList = nil
	end

	if arg_10_0.cardItem then
		arg_10_0.cardItem:destroy()

		arg_10_0.cardItem = nil
	end

	arg_10_0:__onDispose()
end

return var_0_0
