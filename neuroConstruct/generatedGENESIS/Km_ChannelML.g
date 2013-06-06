

// **************************************************
// File generated by: neuroConstruct v1.7.0 
// **************************************************

// This file holds the implementation in GENESIS of the Cell Mechanism:
// Km_ChannelML (Type: Channel mechanism, Model: ChannelML based process)

// with parameters: 
// /channelml/@units = SI Units 
// /channelml/notes = ChannelML file containing a single Channel description 
// /channelml/channel_type/@name = Km_ChannelML 
// /channelml/channel_type/status/@value = stable 
// /channelml/channel_type/status/comment = Equations fromM. C. Vanier and J. M. Bower, A Comparative Survey of Automated Parameter-Searching Methods for Compartmental Neural Models 
// /channelml/channel_type/status/contributor/name = Simon O'Connor 
// /channelml/channel_type/notes = Non inactivating Muscarinic type K channel, with rate equations expressed in tau and inf form 
// /channelml/channel_type/authorList/modelTranslator/name = Simon O'Connor 
// /channelml/channel_type/authorList/modelTranslator/institution = Cardiff University 
// /channelml/channel_type/authorList/modelTranslator/email = simon.oconnor - at - btinternet.com 
// /channelml/channel_type/publication/fullTitle = M. C. Vanier and J. M. Bower, A Comparative Survey of Automated Parameter-Searching Methods for Compartmental Neural Models, . 
// /channelml/channel_type/publication/pubmedRef = http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&amp;db=pubmed&amp;dopt=Abstract&amp;list_uids=12991237 
// /channelml/channel_type/neuronDBref/modelName = K channels 
// /channelml/channel_type/neuronDBref/uri = http://senselab.med.yale.edu/senselab/NeuronDB/channelGene2.htm#table3 
// /channelml/channel_type/current_voltage_relation/@cond_law = ohmic 
// /channelml/channel_type/current_voltage_relation/@ion = k 
// /channelml/channel_type/current_voltage_relation/@default_gmax = 100.0 
// /channelml/channel_type/current_voltage_relation/@default_erev = -0.096 
// /channelml/channel_type/current_voltage_relation/gate/@name = m 
// /channelml/channel_type/current_voltage_relation/gate/@instances = 1 
// /channelml/channel_type/current_voltage_relation/gate/closed_state/@id = m0 
// /channelml/channel_type/current_voltage_relation/gate/open_state/@id = m 
// /channelml/channel_type/current_voltage_relation/gate/time_course/@name = tau 
// /channelml/channel_type/current_voltage_relation/gate/time_course/@from = m0 
// /channelml/channel_type/current_voltage_relation/gate/time_course/@to = m 
// /channelml/channel_type/current_voltage_relation/gate/time_course/@expr_form = generic 
// /channelml/channel_type/current_voltage_relation/gate/time_course/@expr = 0.33 * (0.033 + 1.0 / (11.3 * ((exp ((v + 0.035) /0.02))) + (exp (-1.0 * (v + 0.035)/ 0.01)))) 
// /channelml/channel_type/current_voltage_relation/gate/steady_state/@name = inf 
// /channelml/channel_type/current_voltage_relation/gate/steady_state/@from = m0 
// /channelml/channel_type/current_voltage_relation/gate/steady_state/@to = m 
// /channelml/channel_type/current_voltage_relation/gate/steady_state/@expr_form = generic 
// /channelml/channel_type/current_voltage_relation/gate/steady_state/@expr = 1.0 / (1.0 + (exp (-1.0 * (v + 0.035)/ 0.01))) 
// /channelml/channel_type/impl_prefs/table_settings/@max_v = 0.1 
// /channelml/channel_type/impl_prefs/table_settings/@min_v = -0.1 
// /channelml/channel_type/impl_prefs/table_settings/@table_divisions = 3000 

// File from which this was generated: /home/Simon/PiriformCortexPyramidalNeuron/neuroConstruct/cellMechanisms/Km_ChannelML/KA_Channel.xml

// XSL file with mapping to simulator: /home/Simon/PiriformCortexPyramidalNeuron/neuroConstruct/cellMechanisms/Km_ChannelML/ChannelML_v1.8.1_GENESIStab.xsl



// This is a GENESIS script file generated from a ChannelML v1.8.1 file
// The ChannelML file is mapped onto a tabchannel object


// Units of ChannelML file: SI Units, units of GENESIS file generated: SI Units

/*
    ChannelML file containing a single Channel description
*/

function make_Km_ChannelML

        /*
            Non inactivating Muscarinic type K channel, with rate equations expressed in tau and inf form

            
Reference: M. C. Vanier and J. M. Bower, A Comparative Survey of Automated Parameter-Searching Methods for Compartmental Neural Models, .
            Pubmed: http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=pubmed&dopt=Abstract&list_uids=12991237

        */
        

        str chanpath = "/library/Km_ChannelML"

        if ({exists {chanpath}})
            return
        end
        
        create tabchannel {chanpath}
            

        setfield {chanpath} \ 
            Ek              -0.096 \
            Ik              0  \
            Xpower          1
        
        setfield {chanpath} \
            Gbar 100.0 \
            Gk              0 

        
        // No Q10 temperature adjustment found
        float temp_adj_m = 1
    

        float tab_divs = 3000
        float v_min = -0.1

        float v_max = 0.1

        float v, dv, i
            
        // Creating table for gate m, using name X for it here

        float dv = ({v_max} - {v_min})/{tab_divs}
            
        call {chanpath} TABCREATE X {tab_divs} {v_min} {v_max}
                
        v = {v_min}

            

        for (i = 0; i <= ({tab_divs}); i = i + 1)
            
            // Looking at rate: tau
                

            float tau
                
                        
            // Found a generic form of rate equation for tau, using expression: 0.33 * (0.033 + 1.0 / (11.3 * ((exp ((v + 0.035) /0.02))) + (exp (-1.0 * (v + 0.035)/ 0.01))))
            // Will translate this for GENESIS compatibility...
                    tau = 0.33 * {0.033 + 1.0 / {11.3 * {{exp {{v + 0.035} /0.02}}} + {exp {-1.0 * {v + 0.035}/ 0.01}}}}
            
            // Looking at rate: inf
                

            float inf
                
                        
            // Found a generic form of rate equation for inf, using expression: 1.0 / (1.0 + (exp (-1.0 * (v + 0.035)/ 0.01)))
            // Will translate this for GENESIS compatibility...
                    inf = 1.0 / {1.0 + {exp {-1.0 * {v + 0.035}/ 0.01}}}
            

            // Evaluating the tau and inf expressions

                    
            tau = tau/temp_adj_m
    

            
            // Working out the "real" alpha and beta expressions from the tau and inf
            
            float alpha
            float beta
            alpha = inf / tau   
            beta = (1- inf)/tau
            
            
            setfield {chanpath} X_A->table[{i}] {alpha}
            setfield {chanpath} X_B->table[{i}] {alpha + beta}

                
            v = v + dv

        end // end of for (i = 0; i <= ({tab_divs}); i = i + 1)
            
        setfield {chanpath} X_A->calc_mode 1 X_B->calc_mode 1
                    


end

