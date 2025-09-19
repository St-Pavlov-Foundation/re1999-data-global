module("modules.logic.survival.view.SurvivalBagItem", package.seeall)

local var_0_0 = class("SurvivalBagItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.goRoot = gohelper.findChild(arg_1_1, "root")
	arg_1_0._animHas = gohelper.findChildAnim(arg_1_1, "root/has")
	arg_1_0._gonormal = gohelper.findChild(arg_1_1, "root/has")
	arg_1_0._goempty = gohelper.findChild(arg_1_1, "root/empty")
	arg_1_0._btnClick = gohelper.findChildButtonWithAudio(arg_1_1, "root/btn_Click")
	arg_1_0._txtnum = gohelper.findChildTextMesh(arg_1_1, "root/has/collection/#txt_num")
	arg_1_0._goqulity5 = gohelper.findChild(arg_1_1, "root/has/collection/#go_qulity")
	arg_1_0._goselect = gohelper.findChild(arg_1_1, "root/has/go_select")
	arg_1_0._goitem = gohelper.findChild(arg_1_0._gonormal, "collection")
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0._goitem, "image_Rare")
	arg_1_0._simageitemicon = gohelper.findChildSingleImage(arg_1_0._goitem, "simage_Icon")
	arg_1_0._gotagitem = gohelper.findChild(arg_1_0._goitem, "go_tag/go_item")
	arg_1_0._gonpc = gohelper.findChild(arg_1_0._gonormal, "npc")
	arg_1_0._gotalent = gohelper.findChild(arg_1_0._gonormal, "Talent")
	arg_1_0._gosurvivalequiptag = gohelper.findChild(arg_1_0._gonormal, "go_tag")
	arg_1_0._simagenpcicon = gohelper.findChildSingleImage(arg_1_0._gonpc, "simage_Icon")
	arg_1_0._goadd = gohelper.findChild(arg_1_0.goRoot, "add")
	arg_1_0._goput = gohelper.findChild(arg_1_0.goRoot, "put")
	arg_1_0._goloading = gohelper.findChild(arg_1_1, "root/loading")
	arg_1_0._gosearching = gohelper.findChild(arg_1_1, "root/searching")
	arg_1_0._gocompose = gohelper.findChild(arg_1_0.goRoot, "compose")
	arg_1_0._goCollectionSelectTips = gohelper.findChild(arg_1_0._gonormal, "collection/#go_collection_select_Tips")

	gohelper.setActive(arg_1_0._gotalent, false)
	gohelper.setActive(arg_1_0._goCollectionSelectTips, false)

	arg_1_0.defaultWidth = 172
	arg_1_0.defaultHeight = 172
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnClick:AddClickListener(arg_2_0._onItemClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnClick:RemoveClickListener()
end

function var_0_0.updateByItemId(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = SurvivalBagItemMo.New()

	var_4_0:init({
		id = arg_4_1,
		count = arg_4_2
	})
	arg_4_0:updateMo(var_4_0)
end

function var_0_0.updateMo(arg_5_0, arg_5_1)
	local var_5_0 = false

	if arg_5_0._preUid and arg_5_1.uid == arg_5_0._preUid and arg_5_1.count > arg_5_0._preCount then
		var_5_0 = true
	end

	arg_5_0._mo = arg_5_1
	arg_5_0._preUid = arg_5_1.uid
	arg_5_0._preCount = arg_5_1.count

	local var_5_1 = arg_5_1:isEmpty()

	gohelper.setActive(arg_5_0._gonormal, not var_5_1)

	if not var_5_1 then
		if arg_5_1.co.rare == 5 then
			arg_5_0._animHas:Play("opensp", 0, 1)
		else
			arg_5_0._animHas:Play("open", 0, 1)
		end
	end

	gohelper.setActive(arg_5_0._gocompose, false)
	gohelper.setActive(arg_5_0._gosearching, false)
	gohelper.setActive(arg_5_0._goput, false)
	gohelper.setActive(arg_5_0._goempty, var_5_1)
	gohelper.setActive(arg_5_0._goadd, false)
	gohelper.setActive(arg_5_0._gosurvivalequiptag, false)
	gohelper.setActive(arg_5_0._goadd, var_5_0)

	if not var_5_1 then
		local var_5_2 = arg_5_1.co.type == SurvivalEnum.ItemType.NPC
		local var_5_3 = arg_5_1.equipCo

		gohelper.setActive(arg_5_0._gonpc, var_5_2)
		gohelper.setActive(arg_5_0._gosurvivalequiptag, var_5_3 and arg_5_1.bagReason == 1)
		gohelper.setActive(arg_5_0._goitem, not var_5_2)
		gohelper.setActive(arg_5_0._goqulity5, not var_5_2 and arg_5_1.co.rare == 5)

		arg_5_0._txtnum.text = arg_5_0._mo.count

		local var_5_4 = {}

		if not var_5_2 then
			UISpriteSetMgr.instance:setSurvivalSprite(arg_5_0._imagerare, "survival_bag_itemquality" .. arg_5_0._mo.co.rare)
			arg_5_0._simageitemicon:LoadImage(ResUrl.getSurvivalItemIcon(arg_5_0._mo.co.icon))
		else
			arg_5_0._simagenpcicon:LoadImage(ResUrl.getSurvivalNpcIcon(arg_5_0._mo.co.icon))
		end

		if var_5_3 then
			var_5_4 = string.splitToNumber(var_5_3.tag, "#") or {}
		end

		gohelper.CreateObjList(arg_5_0, arg_5_0._createTagItem, var_5_4, nil, arg_5_0._gotagitem)
	end

	arg_5_0:setIsSelect(false)
end

function var_0_0._createTagItem(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = gohelper.findChildImage(arg_6_1, "#image_tag")
	local var_6_1 = lua_survival_equip_found.configDict[arg_6_2]

	if not var_6_1 then
		return
	end

	UISpriteSetMgr.instance:setSurvivalSprite(var_6_0, var_6_1.icon4)
end

function var_0_0.setShowNum(arg_7_0, arg_7_1)
	gohelper.setActive(arg_7_0._txtnum, arg_7_1)
end

function var_0_0.setClickCallback(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._callback = arg_8_1
	arg_8_0._callobj = arg_8_2
end

function var_0_0.setIsSelect(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._goselect, arg_9_1)
end

function var_0_0.setCanClickEmpty(arg_10_0, arg_10_1)
	arg_10_0._canClickEmpty = arg_10_1
end

function var_0_0._onItemClick(arg_11_0)
	if arg_11_0._mo:isEmpty() and not arg_11_0._canClickEmpty then
		return
	end

	if arg_11_0._callback then
		arg_11_0._callback(arg_11_0._callobj, arg_11_0)

		return
	end
end

function var_0_0.showLoading(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0._goloading, arg_12_1)

	if arg_12_1 then
		gohelper.setActive(arg_12_0._goempty, false)
		gohelper.setActive(arg_12_0._gonormal, false)
	else
		arg_12_0:updateMo(arg_12_0._mo)

		if arg_12_0._mo and arg_12_0._mo.co and arg_12_0._mo.co.rare == 5 then
			arg_12_0._animHas:Play("opensp", 0, 0)
			AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_binansuo_sougua_4)
		else
			arg_12_0._animHas:Play("open", 0, 0)
		end
	end
end

function var_0_0.playSearch(arg_13_0)
	gohelper.setActive(arg_13_0._gosearching, false)
	gohelper.setActive(arg_13_0._gosearching, true)
end

function var_0_0.playCompose(arg_14_0)
	gohelper.setActive(arg_14_0._gocompose, false)
	gohelper.setActive(arg_14_0._gocompose, true)
end

function var_0_0.playPut(arg_15_0)
	gohelper.setActive(arg_15_0._goput, false)
	gohelper.setActive(arg_15_0._goput, true)
end

function var_0_0.playComposeAnim(arg_16_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_qiutu_teleport)
	arg_16_0._animHas:Play("compose", 0, 0)
end

function var_0_0.setItemSize(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1 / arg_17_0.defaultWidth
	local var_17_1 = arg_17_2 / arg_17_0.defaultHeight

	recthelper.setSize(arg_17_0.go.transform, arg_17_1, arg_17_2)
	transformhelper.setLocalScale(arg_17_0.goRoot.transform, var_17_0, var_17_1, 1)
end

function var_0_0.playCloseAnim(arg_18_0)
	arg_18_0._animHas:Play("close", 0, 0)
end

return var_0_0
