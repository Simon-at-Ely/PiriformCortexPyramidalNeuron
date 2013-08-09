

// **************************************************
// File generated by: neuroConstruct v1.7.0 
// **************************************************

// This file holds the implementation in GENESIS of the Cell Mechanism:
// Kahp2_ChannelML (Type: Channel mechanism, Model: ChannelML based process)

// with parameters: 
// /channelml/@units = SI Units 
// /channelml/notes = A channel from Maex, R and De Schutter, E. Synchronization of Golgi and Granule Cell Firing in a      Detailed Network Model of the Cerebellar Granule ... 
// /channelml/channel_type/@name = Kahp2_ChannelML 
// /channelml/channel_type/status/@value = stable 
// /channelml/channel_type/status/comment = Equations fromM. C. Vanier and J. M. Bower, A Comparative Survey of Automated Parameter-Searching Methods for Compartmental Neural Models 
// /channelml/channel_type/status/contributor/name = Simon O'Connor 
// /channelml/channel_type/notes = Calcium concentration dependent K+ channel 
// /channelml/channel_type/authorList/modelTranslator/name = Simon O'Connor 
// /channelml/channel_type/authorList/modelTranslator/institution = Cardiff University 
// /channelml/channel_type/authorList/modelTranslator/email = simon.oconnor - at - btinternet.com 
// /channelml/channel_type/publication/fullTitle = M. C. Vanier and J. M. Bower, A Comparative Survey of Automated Parameter-Searching Methods for Compartmental Neural Models, . 
// /channelml/channel_type/publication/pubmedRef = http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&amp;db=pubmed&amp;dopt=Abstract&amp;list_uids=12991237 
// /channelml/channel_type/neuronDBref/modelName = K+ channels 
// /channelml/channel_type/neuronDBref/uri = http://senselab.med.yale.edu/senselab/NeuronDB/channelGene2.htm#table3 
// /channelml/channel_type/current_voltage_relation/@cond_law = ohmic 
// /channelml/channel_type/current_voltage_relation/@ion = k 
// /channelml/channel_type/current_voltage_relation/@default_gmax = 20.0 
// /channelml/channel_type/current_voltage_relation/@default_erev = -0.096 
// /channelml/channel_type/current_voltage_relation/conc_dependence/@name = Calcium 
// /channelml/channel_type/current_voltage_relation/conc_dependence/@ion = ca 
// /channelml/channel_type/current_voltage_relation/conc_dependence/@charge = 2 
// /channelml/channel_type/current_voltage_relation/conc_dependence/@variable_name = ca_conc 
// /channelml/channel_type/current_voltage_relation/conc_dependence/@min_conc = 0.0 
// /channelml/channel_type/current_voltage_relation/conc_dependence/@max_conc = 5.2e-06 
// /channelml/channel_type/current_voltage_relation/gate/@name = m 
// /channelml/channel_type/current_voltage_relation/gate/@instances = 1 
// /channelml/channel_type/current_voltage_relation/gate/closed_state/@id = m0 
// /channelml/channel_type/current_voltage_relation/gate/open_state/@id = m 
// /channelml/channel_type/current_voltage_relation/gate/transition[1]/@name = alpha 
// /channelml/channel_type/current_voltage_relation/gate/transition[1]/@from = m0 
// /channelml/channel_type/current_voltage_relation/gate/transition[1]/@to = m 
// /channelml/channel_type/current_voltage_relation/gate/transition[1]/@expr_form = generic 
// /channelml/channel_type/current_voltage_relation/gate/transition[1]/@expr = ca_conc &lt; 4.2e-06 ? 100.0 * ca_conc/ 8.2e-06 : 100.0 
// /channelml/channel_type/current_voltage_relation/gate/transition[2]/@name = beta 
// /channelml/channel_type/current_voltage_relation/gate/transition[2]/@from = m 
// /channelml/channel_type/current_voltage_relation/gate/transition[2]/@to = m0 
// /channelml/channel_type/current_voltage_relation/gate/transition[2]/@expr_form = generic 
// /channelml/channel_type/current_voltage_relation/gate/transition[2]/@expr = 5.0 
// /channelml/channel_type/impl_prefs/table_settings/@table_divisions = 3000 

// File from which this was generated: /home/Simon/PiriformCortexPyramidalNeuron/neuroConstruct/cellMechanisms/Kahp2_ChannelML/KCa_Channel.xml

// XSL file with mapping to simulator: /home/Simon/PiriformCortexPyramidalNeuron/neuroConstruct/cellMechanisms/Kahp2_ChannelML/ChannelML_v1.8.1_GENESIStab.xsl



// This is a GENESIS script file generated from a ChannelML v1.8.1 file
// The ChannelML file is mapped onto a tabchannel object


// Units of ChannelML file: SI Units, units of GENESIS file generated: SI Units

/*
    A channel from Maex, R and De Schutter, E. Synchronization of Golgi and Granule Cell Firing in a 
    Detailed Network Model of the Cerebellar Granule Cell Layer
*/

function make_Kahp2_ChannelML

        /*
            Calcium concentration dependent K+ channel

            
Reference: M. C. Vanier and J. M. Bower, A Comparative Survey of Automated Parameter-Searching Methods for Compartmental Neural Models, .
            Pubmed: http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=pubmed&dopt=Abstract&list_uids=12991237

        */
        

        str chanpath = "/library/Kahp2_ChannelML"

        if ({exists {chanpath}})
            return
        end
        
        create tabchannel {chanpath}
            

        setfield {chanpath} \ 
            Ek              -0.096 \
            Ik              0  \
            Zpower          1
        
        setfield {chanpath} \
            Gbar 20.0 \
            Gk              0 

        
        // No Q10 temperature adjustment found
        float temp_adj_m = 1
    

        float tab_divs = 3000

        // Channel is dependent on concentration of: Calcium, rate equations will involve variable: ca_conc
        float c
        float conc_min = 0.0
        float conc_max = 5.2e-06

        float dc = ({conc_max} - {conc_min})/{tab_divs}

        float ca_conc = {conc_min}

            


            
        call {chanpath} TABCREATE Z {tab_divs} {conc_min} {conc_max}
            

        for (c = 0; c <= ({tab_divs}); c = c + 1)
                    
            // Looking at rate: alpha
                

            float alpha
                
                        
            // Found a generic form of rate equation for alpha, using expression: ca_conc < 4.2e-06 ? 100.0 * ca_conc/ 8.2e-06 : 100.0
            // Will translate this for GENESIS compatibility...
                    

            if (ca_conc < 4.2e-06 )
                alpha =  100.0 * ca_conc/ 8.2e-06 
            else
                alpha =  100.0
            end
        
            
            // Looking at rate: beta
                

            float beta
                
                        
            // Found a generic form of rate equation for beta, using expression: 5.0
            // Will translate this for GENESIS compatibility...
                    beta = 5.0
            

            // Using the alpha and beta expressions to populate the tables

            float tau = 1/(temp_adj_m * (alpha + beta))
            
            setfield {chanpath} Z_A->table[{c}] {temp_adj_m * alpha}
            setfield {chanpath} Z_B->table[{c}] {temp_adj_m * (alpha + beta)}
                    ca_conc = ca_conc + dc
                
                
        end // end of for (c = 0; c <= ({tab_divs}); c = c + 1)
                
        setfield {chanpath} Z_conc 1
        setfield {chanpath} Z_A->calc_mode 1 Z_B->calc_mode 1
                    


end

