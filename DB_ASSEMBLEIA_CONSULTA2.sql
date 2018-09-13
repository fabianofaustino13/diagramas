select pk_mor from tb_moradores where mor_login='fab123';

select pk_apa from tb_apartamentos join tb_blocos on pk_blo=fk_apa_blo where apa_nome='101' and blo_nome='torre 2';

select count(*) from tb_apartamentos_moradores where fk_adm_apa='61' and fk_adm_mor='6';

select count(*) from tb_apartamentos where pk_apa='1' and fk_apa_mor='2';


insert into tb_apartamentos_moradores (fk_adm_apa, fk_adm_mor, ativo) values (61, 6, true);

update tb_apartamentos_moradores set ativo=true where fk_adm_apa='61' and fk_adm_mor='6';