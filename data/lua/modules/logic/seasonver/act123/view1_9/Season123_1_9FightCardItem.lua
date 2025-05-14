module("modules.logic.seasonver.act123.view1_9.Season123_1_9FightCardItem", package.seeall)

local var_0_0 = class("Season123_1_9FightCardItem", UserDataDispose)

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

	arg_2_0.equipId = arg_2_1.equipId
	arg_2_0.heroUid = arg_2_1.heroUid
	arg_2_0.isMainRole = not arg_2_0.heroUid

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
		local var_3_0 = arg_3_0:getHeroMO()
		local var_3_1 = var_3_0 and var_3_0.config and var_3_0.config.name or ""

		arg_3_0.txtName.text = formatLuaLang("seasoncardnames", var_3_1)
	end
end

function var_0_0._setHead(arg_4_0)
	local var_4_0 = Activity123Enum.MainRoleHeadIconID

	if not arg_4_0.isMainRole then
		local var_4_1 = arg_4_0:getHeroMO()

		if var_4_1 and var_4_1.skin then
			local var_4_2 = SkinConfig.instance:getSkinCo(var_4_1.skin)

			var_4_0 = var_4_2 and var_4_2.headIcon
		end
	end

	gohelper.getSingleImage(arg_4_0.imageHead.gameObject):LoadImage(ResUrl.roomHeadIcon(var_4_0))
end

function var_0_0.getHeroMO(arg_5_0)
	local var_5_0 = Season123Model.instance:getBattleContext()

	if var_5_0 and var_5_0.stage ~= nil and var_5_0.actId ~= nil then
		return Season123HeroUtils.getHeroMO(var_5_0.actId, arg_5_0.heroUid, var_5_0.stage)
	else
		return HeroModel.instance:getById(arg_5_0.heroUid)
	end
end

function var_0_0._setCard(arg_6_0, arg_6_1)
	if not arg_6_0.cardItem then
		arg_6_0.cardItem = Season123_1_9CelebrityCardItem.New()

		arg_6_0.cardItem:init(arg_6_0.goCardPos, arg_6_1, {
			noClick = true
		})
	else
		arg_6_0.cardItem:reset(arg_6_1)
	end

	local var_6_0 = Season123Config.instance:getSeasonEquipCo(arg_6_1).rare
	local var_6_1 = var_0_0.RoleCardPos[tonumber(var_6_0)] or Vector2(0, 0)

	recthelper.setAnchor(arg_6_0.goCardPos.transform, var_6_1.x, var_6_1.y)
end

function var_0_0._setDesc(arg_7_0, arg_7_1)
	local var_7_0 = Season123Config.instance:getSeasonEquipCo(arg_7_1)

	if arg_7_0.isMainRole then
		gohelper.setActive(arg_7_0.goSpecialCardName, true)
		gohelper.setActive(arg_7_0.goNormalName, false)

		arg_7_0.txtSpecialCardName.text = var_7_0.name
	else
		gohelper.setActive(arg_7_0.goNormalName, true)
		gohelper.setActive(arg_7_0.goSpecialCardName, false)

		arg_7_0.txtNormalCardName.text = var_7_0.name
	end

	local var_7_1 = Season123EquipMetaUtils.getSkillEffectStrList(var_7_0)
	local var_7_2 = Season123EquipMetaUtils.getEquipPropsStrList(var_7_0.attrId)
	local var_7_3 = {}

	for iter_7_0, iter_7_1 in ipairs(var_7_2) do
		table.insert(var_7_3, iter_7_1)
	end

	for iter_7_2, iter_7_3 in ipairs(var_7_1) do
		table.insert(var_7_3, iter_7_3)
	end

	if not arg_7_0.itemList then
		arg_7_0.itemList = arg_7_0:getUserDataTb_()
	end

	for iter_7_4 = 1, math.max(#arg_7_0.itemList, #var_7_3) do
		local var_7_4 = var_7_3[iter_7_4]
		local var_7_5 = arg_7_0.itemList[iter_7_4] or arg_7_0:createDescItem(iter_7_4)

		arg_7_0:updateDescItem(var_7_5, var_7_4)
	end
end

function var_0_0.createDescItem(arg_8_0, arg_8_1)
	local var_8_0 = {}
	local var_8_1 = gohelper.cloneInPlace(arg_8_0._goDesc, string.format("desc%s", arg_8_1))

	var_8_0.go = var_8_1
	var_8_0.txtDesc = var_8_1:GetComponent(typeof(TMPro.TMP_Text))
	arg_8_0.itemList[arg_8_1] = var_8_0

	return var_8_0
end

function var_0_0.updateDescItem(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_2 then
		gohelper.setActive(arg_9_1.go, false)

		return
	end

	gohelper.setActive(arg_9_1.go, true)

	arg_9_1.txtDesc.text = arg_9_2 or ""
end

function var_0_0.destroyDescItem(arg_10_0, arg_10_1)
	return
end

function var_0_0.destroy(arg_11_0)
	if arg_11_0.itemList then
		for iter_11_0, iter_11_1 in ipairs(arg_11_0.itemList) do
			arg_11_0:destroyDescItem(iter_11_1)
		end

		arg_11_0.itemList = nil
	end

	if arg_11_0.cardItem then
		arg_11_0.cardItem:destroy()

		arg_11_0.cardItem = nil
	end

	arg_11_0:__onDispose()
end

return var_0_0
