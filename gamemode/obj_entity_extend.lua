local meta = FindMetaTable("Entity")
if not meta then return end

function meta:TakeSpecialDamage(amount, type, attacker, inflictor)
	local dmginfo = DamageInfo()
	dmginfo:SetDamage(amount)
	dmginfo:SetDamageType(type)
	dmginfo:SetAttacker(attacker)
	dmginfo:SetInflictor(inflictor)
	
	self:TakeDamageInfo(dmginfo)
end